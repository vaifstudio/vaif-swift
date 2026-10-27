import Foundation
import Testing
@testable import VaifClient

struct ConformanceFailure: Error { let message: String }

struct SharedCases: Decodable {
    let version: Int
    let cases: [Case]
    struct Case: Decodable {
        let id: String
        let requires: String?
        let setup: JSONValue
        let steps: [Step]
    }
    struct Step: Decodable {
        let op: String
        let actor: String?
        let args: JSONValue?
        let `as`: String?
        let expect: JSONValue
    }
    static func load() throws -> SharedCases {
        let file = ProcessInfo.processInfo.environment["CONFORMANCE_CASES"].map { URL(fileURLWithPath: $0) }
            ?? Bundle.module.url(forResource: "core", withExtension: "json", subdirectory: "Fixtures")!
        let result = try JSONDecoder().decode(SharedCases.self, from: Data(contentsOf: file))
        let supported = Set(["signUp", "setAuth", "createRow", "listRows", "getRow", "updateRow", "deleteRow", "rotateSigningKey", "storageUpload", "storageDownload", "storageList", "invokeFunction", "realtimeRoundTrip"])
        guard result.version == 1, !result.cases.isEmpty, Set(result.cases.map(\.id)).count == result.cases.count,
              result.cases.allSatisfy({ !$0.steps.isEmpty && $0.steps.allSatisfy { supported.contains($0.op) && $0.expect.objectValue != nil } }) else {
            throw ConformanceFailure(message: "Invalid shared cases")
        }
        return result
    }
}

func valueAt(_ value: JSONValue, _ path: String) -> JSONValue? {
    path.split(separator: ".").reduce(Optional(value)) { $0?[String($1)] }
}

func resolve(_ value: JSONValue, state: [String: JSONValue]) throws -> JSONValue {
    switch value {
    case .string(let text) where text.hasPrefix("$"):
        guard let found = valueAt(.object(state), String(text.dropFirst())), !found.isNull else { throw ConformanceFailure(message: "Unresolved reference") }
        return found
    case .array(let values): return .array(try values.map { try resolve($0, state: state) })
    case .object(let values): return .object(try values.mapValues { try resolve($0, state: state) })
    default: return value
    }
}

func checkExpected(_ actual: JSONValue, _ expected: JSONValue, state: [String: JSONValue]) throws {
    for path in expected["has"]?.arrayValue ?? [] {
        guard let name = path.stringValue, let found = valueAt(actual, name), !found.isNull, found != "", found != false else { throw ConformanceFailure(message: "Missing required value") }
    }
    for (path, wanted) in expected["equals"]?.objectValue ?? [:] {
        guard valueAt(actual, path) == (try resolve(wanted, state: state)) else { throw ConformanceFailure(message: "Mismatch at \(path)") }
    }
    for (path, length) in expected["length"]?.objectValue ?? [:] {
        guard valueAt(actual, path)?.arrayValue?.count == length.intValue else { throw ConformanceFailure(message: "Length mismatch at \(path)") }
    }
    if let key = expected["includesKey"] {
        guard (actual["files"]?.arrayValue ?? []).contains(where: { $0["key"] == key }) else { throw ConformanceFailure(message: "Uploaded key absent") }
    }
}

struct ConformanceFixture {
    let projectId: String
    let table: String
    let bucketId: String
    let bucketName: String
    let actors: [String: VaifClient]
}

@MainActor
struct SharedAdapter {
    let fixture: ConformanceFixture
    let stamp: String
    let rotate: () async throws -> Void

    func operate(_ step: SharedCases.Step, state: [String: JSONValue]) async throws -> JSONValue {
        let args = try resolve(step.args ?? [:], state: state)
        guard let client = fixture.actors[step.actor ?? "service"] else { throw ConformanceFailure(message: "Unknown actor") }
        let table = client.from(fixture.table)
        func text(_ name: String) throws -> String {
            guard let value = args[name]?.stringValue else { throw ConformanceFailure(message: "Missing argument") }; return value
        }
        switch step.op {
        case "signUp":
            let result = try await client.auth.signUp(email: "\(step.actor!)-\(stamp)@vaif-local.test", password: "Local-\(stamp)-Pw!Aa1234")
            return ["accessToken": result.session.map { .string($0.accessToken) } ?? .null, "user": ["id": result.user.map { .string($0.id) } ?? .null]]
        case "setAuth":
            try await client.auth.setSession(accessToken: text("token"), refreshToken: nil); return [:]
        case "createRow": return .object(try await table.insert(args))
        case "listRows":
            let result = try await table.list(); return ["data": .array(result.data.map(JSONValue.object)), "count": .integer(result.count)]
        case "getRow": return .object(try await table.get(text("id")))
        case "updateRow": return .object(try await table.update(text("id"), args["values"] ?? [:]))
        case "deleteRow": try await table.delete(text("id")); return [:]
        case "rotateSigningKey": try await rotate(); return [:]
        case "storageUpload":
            try await client.storage.upload(text("key"), data: Data(text("text").utf8), contentType: "text/plain", bucket: fixture.bucketName); return [:]
        case "storageDownload":
            return ["text": .string(String(decoding: try await client.storage.download(text("key"), bucket: fixture.bucketName), as: UTF8.self))]
        case "storageList":
            // Bucket routes need a console account; the bucket is named, and resolved to its ID.
            let result = try await fixture.actors["console"]!.storage.list(bucket: fixture.bucketName)
            return ["files": .array(result.files.map { ["key": .string($0.key)] })]
        case "invokeFunction": return try await client.functions.invoke(text("name"), body: [:]).json()
        case "realtimeRoundTrip":
            let sub = try await client.realtime.subscribe(table: fixture.table)
            do {
                let row = try await table.insert(["owner_id": .string(UUID().uuidString), "body": "realtime"] as Row)
                do {
                    var iterator = sub.events.makeAsyncIterator()
                    guard let event = try await iterator.next() else { throw ConformanceFailure(message: "No realtime event") }
                    try await table.delete(row["id"]!.stringValue!)
                    await sub.unsubscribe()
                    return ["op": .string(event.operation)]
                } catch { try? await table.delete(row["id"]!.stringValue!); throw error }
            } catch { await sub.unsubscribe(); throw error }
        default: throw ConformanceFailure(message: "Unsupported operation")
        }
    }

    func run(_ definition: SharedCases.Case) async throws {
        var state: [String: JSONValue] = [:]
        for step in definition.steps {
            do {
                let value = try await operate(step, state: state)
                if step.expect["error"] != nil { throw ConformanceFailure(message: "Expected error at \(step.op)") }
                try checkExpected(value, step.expect, state: state)
                if let name = step.as { state[name] = value }
            } catch let error as VaifError {
                guard let expected = step.expect["error"], expected["status"]?.intValue == error.status, expected["code"]?.stringValue == error.code else { throw error }
            }
        }
    }
}

/// A stateful fake server exercises the same case adapter and SDK serialization.
/// This is unit evidence only, not proof of live API behavior.
final class ConformanceServer: @unchecked Sendable {
    private let lock = NSLock()
    private var rows: [Row] = []
    private var bytes = Data()
    private var key = ""
    private var rotated = false
    func rotate() { lock.lock(); rotated = true; lock.unlock() }
    func respond(_ request: Recorded) -> Reply {
        lock.lock(); defer { lock.unlock() }
        if request.path.hasSuffix("/signup") {
            let email = request.json?["email"]?.stringValue ?? ""
            let actor = email.hasPrefix("alice-") ? "alice" : "bob"
            return .json(200, ["accessToken": .string(actor), "user": ["id": .string(actor)], "expiresIn": 900])
        }
        let actor = request.header("Authorization")?.replacingOccurrences(of: "Bearer ", with: "")
        if request.path.contains("/v1/data/") {
            if rotated && (actor == "alice" || actor == "bob") { return .json(401, ["code": "TOKEN_INVALID", "message": "Rotated key"]) }
            if request.method == "POST" {
                var row = request.json?.objectValue ?? [:]; row["id"] = "row-1"; row["owner_id"] = .string(actor ?? "service"); rows.append(row)
                return .json(201, ["data": .object(row)])
            }
            if request.method == "PATCH" {
                rows[0].merge(request.json?.objectValue ?? [:]) { _, new in new }; return .json(200, ["data": .object(rows[0])])
            }
            if request.method == "DELETE" { rows = []; return .status(204) }
            let visible = rows.filter { $0["owner_id"] == actor.map(JSONValue.string) }
            if request.path.hasSuffix("/row-1") { return .json(200, ["data": .object(visible[0])]) }
            return .json(200, ["data": .array(visible.map(JSONValue.object)), "count": .integer(visible.count)])
        }
        if request.path == "/storage/upload-url" {
            key = request.json?["key"]?.stringValue ?? ""
            guard request.json?["sizeBytes"]?.intValue ?? 0 > 0 else { return .status(400) }
            return .json(200, ["url": .string(request.url.deletingLastPathComponent().appendingPathComponent("object").absoluteString)])
        }
        if request.method == "PUT" { bytes = request.body; return .status(200) }
        // As the API does: a signed link on the object store, read without credentials.
        if request.path == "/storage/download-url" {
            return .json(200, ["ok": true, "url": .string(request.url.deletingLastPathComponent().appendingPathComponent("object").absoluteString)])
        }
        if request.method == "GET", request.path == "/storage/object", request.header("x-vaif-key") == nil { return Reply(body: bytes) }
        if request.path == "/storage/buckets" {
            return .json(200, ["ok": true, "buckets": [["id": "0f8fad5b-d9cb-469f-a165-70867728950e", "name": "test"]]])
        }
        if request.path == "/buckets/0f8fad5b-d9cb-469f-a165-70867728950e/files" { return .json(200, ["files": [["key": .string(key), "size": .integer(bytes.count)]]]) }
        if request.path.contains("/functions/") { return .json(200, ["message": "Hello from VAIF Functions!"]) }
        return .status(404)
    }
}

@Suite struct SwiftConformance {
    @Test @MainActor func fakeTransportSharedCases() async throws {
        let cases = try SharedCases.load()
        let server = ConformanceServer()
        let stub = Stub { request, _ in server.respond(request) }
        let actors = try Dictionary(uniqueKeysWithValues: ["alice", "bob", "service", "console"].map { ($0, try makeClient(stub, retry: .none)) })
        let fixture = ConformanceFixture(projectId: testProject, table: "notes", bucketId: "bucket", bucketName: "test", actors: actors)
        let adapter = SharedAdapter(fixture: fixture, stamp: "fake", rotate: { server.rotate() })
        for definition in cases.cases where definition.requires != "realtime" {
            try await adapter.run(definition)
        }
    }

    @Test func expectedChecksRejectBadValues() throws {
        #expect(throws: (any Error).self) { try checkExpected(["count": 1], ["equals": ["count": 0]], state: [:]) }
        #expect(throws: (any Error).self) { try resolve("$missing.token", state: [:]) }
        #expect(throws: (any Error).self) { try checkExpected(["files": []], ["includesKey": "missing"], state: [:]) }
    }
}
