/// Retry Logic
///
/// Exponential backoff with jitter for transient errors.

import Foundation

/// Configuration for retry behavior.
public struct RetryConfig: Sendable {
    /// Maximum number of retry attempts.
    public let maxRetries: Int

    /// Initial delay between retries in seconds.
    public let initialDelay: TimeInterval

    /// Maximum delay between retries in seconds.
    public let maxDelay: TimeInterval

    /// Multiplier for exponential backoff.
    public let backoffMultiplier: Double

    /// Whether to add jitter to delay.
    public let jitter: Bool

    /// HTTP status codes that are retryable.
    public let retryableStatusCodes: Set<Int>

    public init(
        maxRetries: Int = 3,
        initialDelay: TimeInterval = 0.5,
        maxDelay: TimeInterval = 30,
        backoffMultiplier: Double = 2.0,
        jitter: Bool = true,
        retryableStatusCodes: Set<Int> = [408, 429, 500, 502, 503, 504]
    ) {
        self.maxRetries = maxRetries
        self.initialDelay = initialDelay
        self.maxDelay = maxDelay
        self.backoffMultiplier = backoffMultiplier
        self.jitter = jitter
        self.retryableStatusCodes = retryableStatusCodes
    }

    public static let none = RetryConfig(maxRetries: 0)
}

/// Execute an async operation with retry logic.
func withRetry<T>(
    config: RetryConfig = RetryConfig(),
    onRetry: ((Int, TimeInterval, String) -> Void)? = nil,
    operation: () async throws -> (T, Int)
) async throws -> (T, Int) {
    var lastError: Error?

    for attempt in 0...config.maxRetries {
        do {
            let (result, status) = try await operation()

            // Success
            if status >= 200 && status < 300 {
                return (result, status)
            }

            // Check if retryable
            let isRetryable = config.retryableStatusCodes.contains(status)
            if !isRetryable || attempt >= config.maxRetries {
                return (result, status)
            }

            // Calculate delay
            let baseDelay = config.initialDelay * pow(config.backoffMultiplier, Double(attempt))
            let clampedDelay = min(baseDelay, config.maxDelay)
            let jitterAmount = config.jitter
                ? Double.random(in: 0...(clampedDelay * 0.25))
                : 0
            let delay = clampedDelay + jitterAmount

            onRetry?(attempt + 1, delay, "Status \(status)")

            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            lastError = error

            if attempt >= config.maxRetries {
                throw error
            }

            let baseDelay = config.initialDelay * pow(config.backoffMultiplier, Double(attempt))
            let clampedDelay = min(baseDelay, config.maxDelay)

            onRetry?(attempt + 1, clampedDelay, "Error: \(error.localizedDescription)")

            try await Task.sleep(nanoseconds: UInt64(clampedDelay * 1_000_000_000))
        }
    }

    throw lastError ?? VaifError.network(underlying: NSError(
        domain: "VaifClient",
        code: -1,
        userInfo: [NSLocalizedDescriptionKey: "Max retries exceeded"]
    ))
}
