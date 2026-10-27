import Foundation

/// How transient failures are retried.
///
/// Only replay-safe requests (GET, HEAD, OPTIONS, or calls marked idempotent)
/// are retried on `retryOn` statuses and network errors. A request that failed
/// before a connection was opened is retried for every method, since the
/// server never saw it.
public struct RetryPolicy: Sendable, Equatable {
    public var maxRetries: Int
    public var baseDelay: TimeInterval
    public var maxDelay: TimeInterval
    public var multiplier: Double
    public var retryOn: Set<Int>
    public var retryOnNetworkError: Bool

    public init(
        maxRetries: Int = 3,
        baseDelay: TimeInterval = 1,
        maxDelay: TimeInterval = 30,
        multiplier: Double = 2,
        retryOn: Set<Int> = [429, 500, 502, 503, 504],
        retryOnNetworkError: Bool = true
    ) {
        self.maxRetries = max(0, maxRetries)
        self.baseDelay = max(0, baseDelay)
        self.maxDelay = max(0, maxDelay)
        self.multiplier = multiplier > 0 ? multiplier : 2
        self.retryOn = retryOn
        self.retryOnNetworkError = retryOnNetworkError
    }

    /// 3 retries, 1 s doubling to 30 s, on 429/500/502/503/504 and network errors.
    public static let `default` = RetryPolicy()
    /// No retries.
    public static let none = RetryPolicy(maxRetries: 0)

    /// Seconds to wait before retry `attempt` (0-based), honoring Retry-After
    /// and adding up to 25% jitter.
    public func delay(forAttempt attempt: Int, retryAfter: TimeInterval? = nil) -> TimeInterval {
        if let retryAfter, retryAfter > 0 { return min(retryAfter, maxDelay) }
        let raw = min(baseDelay * pow(multiplier, Double(attempt)), maxDelay)
        return raw + raw * Double.random(in: 0..<0.25)
    }
}
