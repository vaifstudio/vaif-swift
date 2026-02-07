/// VAIF Realtime Client
///
/// WebSocket-based realtime subscriptions for database changes, broadcasts, and presence.

import Foundation

// MARK: - Realtime Types

/// Channel status
public enum ChannelStatus {
    case subscribed
    case closed
    case errored
    case timedOut
}

/// Realtime options
public struct RealtimeOptions {
    public let heartbeat: Bool
    public let heartbeatInterval: TimeInterval
    public let autoReconnect: Bool
    public let reconnectInterval: TimeInterval
    public let maxReconnectAttempts: Int

    public init(
        heartbeat: Bool = true,
        heartbeatInterval: TimeInterval = 30,
        autoReconnect: Bool = true,
        reconnectInterval: TimeInterval = 1,
        maxReconnectAttempts: Int = 10
    ) {
        self.heartbeat = heartbeat
        self.heartbeatInterval = heartbeatInterval
        self.autoReconnect = autoReconnect
        self.reconnectInterval = reconnectInterval
        self.maxReconnectAttempts = maxReconnectAttempts
    }
}

/// Postgres change event
public struct PostgresChangeEvent {
    public let schema: String
    public let table: String
    public let eventType: String
    public let oldRecord: [String: Any]?
    public let newRecord: [String: Any]?
    public let commitTimestamp: String
}

/// Broadcast message
public struct BroadcastMessage {
    public let event: String
    public let payload: Any
}

// MARK: - Realtime Client

/// Realtime client for VAIF Studio.
public final class VaifRealtime {
    private let client: VaifClient
    private var webSocket: URLSessionWebSocketTask?
    private var channels: [String: RealtimeChannel] = [:]
    private var reconnectAttempts = 0
    private var heartbeatTimer: Timer?
    private var connected = false
    private var options: RealtimeOptions?

    init(client: VaifClient) {
        self.client = client
    }

    /// Connect to realtime server.
    public func connect(options: RealtimeOptions = RealtimeOptions()) {
        guard !connected else { return }

        self.options = options
        let config = client.config

        var urlString = "\(config.realtimeUrl)?apikey=\(config.apiKey)&project=\(config.projectId)"
        if let token = client.getAccessToken() {
            urlString += "&token=\(token)"
        }

        guard let url = URL(string: urlString) else { return }

        let session = URLSession(configuration: .default)
        webSocket = session.webSocketTask(with: url)
        webSocket?.resume()

        connected = true
        reconnectAttempts = 0

        client.debug("Realtime connected")

        // Start heartbeat
        if options.heartbeat {
            startHeartbeat(interval: options.heartbeatInterval)
        }

        // Start receiving
        receiveMessage()

        // Resubscribe channels
        for channel in channels.values {
            channel.resubscribe()
        }
    }

    /// Disconnect from realtime server.
    public func disconnect() {
        connected = false
        heartbeatTimer?.invalidate()
        heartbeatTimer = nil

        for channel in channels.values {
            channel.unsubscribe()
        }
        channels.removeAll()

        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
    }

    /// Create or get a channel.
    public func channel(_ name: String) -> RealtimeChannel {
        if let channel = channels[name] {
            return channel
        }
        let channel = RealtimeChannel(realtime: self, name: name)
        channels[name] = channel
        return channel
    }

    /// Remove a channel.
    public func removeChannel(_ name: String) {
        channels[name]?.unsubscribe()
        channels.removeValue(forKey: name)
    }

    /// Send message to server.
    func send(_ message: [String: Any]) {
        guard connected, let webSocket = webSocket else { return }

        do {
            let data = try JSONSerialization.data(withJSONObject: message)
            let string = String(data: data, encoding: .utf8) ?? ""
            webSocket.send(.string(string)) { _ in }
        } catch {
            client.debug("Failed to send message: \(error)")
        }
    }

    private func receiveMessage() {
        webSocket?.receive { [weak self] result in
            guard let self = self, self.connected else { return }

            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    if let data = text.data(using: .utf8),
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        self.handleMessage(json)
                    }
                case .data(let data):
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        self.handleMessage(json)
                    }
                @unknown default:
                    break
                }
                self.receiveMessage()

            case .failure(let error):
                self.client.debug("WebSocket error: \(error)")
                self.handleDisconnect()
            }
        }
    }

    private func handleMessage(_ message: [String: Any]) {
        guard let topic = message["topic"] as? String,
              let channel = channels[topic] else { return }
        channel.handleMessage(message)
    }

    private func handleDisconnect() {
        connected = false
        heartbeatTimer?.invalidate()
        client.debug("Realtime disconnected")

        guard let options = options, options.autoReconnect else { return }

        if reconnectAttempts < options.maxReconnectAttempts {
            reconnectAttempts += 1
            let delay = min(options.reconnectInterval * Double(reconnectAttempts), 30)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.connect(options: options)
            }
        }
    }

    private func startHeartbeat(interval: TimeInterval) {
        heartbeatTimer?.invalidate()
        heartbeatTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self, self.connected else { return }

            // Send application-level heartbeat
            self.send(["topic": "phoenix", "event": "heartbeat", "payload": [:]])

            // Also send WebSocket ping for connection health
            self.webSocket?.sendPing { [weak self] error in
                if let error = error {
                    self?.client.debug("WebSocket ping failed: \(error)")
                    self?.handleDisconnect()
                }
            }
        }
    }

    /// Whether the realtime client is currently connected.
    public var isConnected: Bool { connected }

    /// Get all active channel names.
    public var activeChannels: [String] { Array(channels.keys) }
}

// MARK: - Realtime Channel

/// Realtime channel for subscriptions.
public final class RealtimeChannel {
    private let realtime: VaifRealtime
    private let name: String
    private var subscriptions: [String: [(Any) -> Void]] = [:]
    private var status: ChannelStatus = .closed
    private var presenceState: [String: [[String: Any]]] = [:]

    init(realtime: VaifRealtime, name: String) {
        self.realtime = realtime
        self.name = name
    }

    /// Subscribe to postgres changes.
    @discardableResult
    public func onPostgresChanges(
        event: String,
        schema: String = "public",
        table: String? = nil,
        filter: String? = nil,
        callback: @escaping (PostgresChangeEvent) -> Void
    ) -> Self {
        var filterDict: [String: Any] = ["event": event, "schema": schema]
        if let table = table { filterDict["table"] = table }
        if let filter = filter { filterDict["filter"] = filter }

        return on("postgres_changes", filter: filterDict) { payload in
            guard let dict = payload as? [String: Any] else { return }
            callback(PostgresChangeEvent(
                schema: dict["schema"] as? String ?? "",
                table: dict["table"] as? String ?? "",
                eventType: dict["eventType"] as? String ?? "",
                oldRecord: dict["old_record"] as? [String: Any],
                newRecord: dict["new_record"] as? [String: Any],
                commitTimestamp: dict["commit_timestamp"] as? String ?? ""
            ))
        }
    }

    /// Subscribe to broadcast events.
    @discardableResult
    public func onBroadcast(
        event: String,
        callback: @escaping (BroadcastMessage) -> Void
    ) -> Self {
        return on("broadcast", filter: ["event": event]) { payload in
            guard let dict = payload as? [String: Any] else { return }
            callback(BroadcastMessage(
                event: dict["event"] as? String ?? "",
                payload: dict["payload"] ?? [:]
            ))
        }
    }

    /// Subscribe to presence events.
    @discardableResult
    public func onPresence(
        event: String,
        callback: @escaping (Any) -> Void
    ) -> Self {
        return on("presence", filter: ["event": event], callback: callback)
    }

    /// Generic subscription.
    @discardableResult
    public func on(
        _ event: String,
        filter: [String: Any],
        callback: @escaping (Any) -> Void
    ) -> Self {
        let key = "\(event):\(filterToString(filter))"
        if subscriptions[key] == nil {
            subscriptions[key] = []
        }
        subscriptions[key]?.append(callback)
        return self
    }

    /// Subscribe to channel.
    @discardableResult
    public func subscribe(
        callback: ((ChannelStatus, Error?) -> Void)? = nil
    ) -> Self {
        realtime.send([
            "topic": name,
            "event": "phx_join",
            "payload": ["subscriptions": Array(subscriptions.keys)],
            "ref": "\(name)-join"
        ])

        status = .subscribed
        callback?(status, nil)

        return self
    }

    /// Unsubscribe from channel.
    public func unsubscribe() {
        realtime.send([
            "topic": name,
            "event": "phx_leave",
            "payload": [:],
            "ref": "\(name)-leave"
        ])
        status = .closed
        subscriptions.removeAll()
    }

    /// Broadcast message to channel.
    public func broadcast(event: String, payload: Any) {
        realtime.send([
            "topic": name,
            "event": "broadcast",
            "payload": ["event": event, "payload": payload]
        ])
    }

    /// Track presence.
    public func track(payload: [String: Any]) {
        realtime.send([
            "topic": name,
            "event": "presence",
            "payload": ["type": "track", "payload": payload]
        ])
    }

    /// Untrack presence.
    public func untrack() {
        realtime.send([
            "topic": name,
            "event": "presence",
            "payload": ["type": "untrack"]
        ])
    }

    /// Get current presence state.
    public func getPresenceState() -> [String: [[String: Any]]] {
        return presenceState
    }

    func handleMessage(_ message: [String: Any]) {
        guard let event = message["event"] as? String,
              let payload = message["payload"] else { return }

        for (key, callbacks) in subscriptions {
            let subEvent = key.components(separatedBy: ":").first ?? ""
            if event == subEvent || event == "broadcast" {
                for callback in callbacks {
                    callback(payload)
                }
            }
        }
    }

    func resubscribe() {
        if !subscriptions.isEmpty {
            _ = subscribe()
        }
    }

    private func filterToString(_ filter: [String: Any]) -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: filter),
              let string = String(data: data, encoding: .utf8) else {
            return ""
        }
        return string
    }
}
