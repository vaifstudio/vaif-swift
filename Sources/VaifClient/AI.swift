/// VAIF AI Client
///
/// AI-powered code generation for schemas, functions, and endpoints.

import Foundation

// MARK: - AI Types

/// Copilot model tiers
public enum CopilotModel: String, Codable {
    /// Fast responses for simple tasks
    case quick = "copilot-quick"
    /// Best balance of speed and capability (default)
    case balanced = "copilot-balanced"
    /// Maximum capability for complex tasks
    case power = "copilot-power"
    /// Enterprise-grade models
    case enterprise = "copilot-enterprise"
}

/// Backward compatibility alias
public typealias AIModel = CopilotModel

/// AI generation options
public struct AIGenerateOptions {
    public let model: CopilotModel?
    public let temperature: Double?
    public let maxTokens: Int?
    public let stream: Bool

    public init(
        model: CopilotModel? = nil,
        temperature: Double? = nil,
        maxTokens: Int? = nil,
        stream: Bool = false
    ) {
        self.model = model
        self.temperature = temperature
        self.maxTokens = maxTokens
        self.stream = stream
    }

    func toDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        if let model = model { dict["model"] = model.rawValue }
        if let temp = temperature { dict["temperature"] = temp }
        if let tokens = maxTokens { dict["maxTokens"] = tokens }
        dict["stream"] = stream
        return dict
    }
}

/// Schema generation request
public struct SchemaGenerationRequest {
    public let prompt: String
    public let format: String
    public let includeRelations: Bool
    public let includeIndexes: Bool
    public let database: String

    public init(
        prompt: String,
        format: String = "sql",
        includeRelations: Bool = true,
        includeIndexes: Bool = true,
        database: String = "postgresql"
    ) {
        self.prompt = prompt
        self.format = format
        self.includeRelations = includeRelations
        self.includeIndexes = includeIndexes
        self.database = database
    }

    func toDict() -> [String: Any] {
        return [
            "prompt": prompt,
            "format": format,
            "includeRelations": includeRelations,
            "includeIndexes": includeIndexes,
            "database": database
        ]
    }
}

/// Schema generation result
public struct SchemaGenerationResult: Codable {
    public let schema: String
    public let format: String
    public let tables: [[String: Any]]
    public let types: String?
    public let explanation: String?
    public let creditsUsed: Int

    enum CodingKeys: String, CodingKey {
        case schema, format, tables, types, explanation, creditsUsed
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        schema = try container.decode(String.self, forKey: .schema)
        format = try container.decode(String.self, forKey: .format)
        tables = [] // Simplified for complex nested types
        types = try container.decodeIfPresent(String.self, forKey: .types)
        explanation = try container.decodeIfPresent(String.self, forKey: .explanation)
        creditsUsed = try container.decode(Int.self, forKey: .creditsUsed)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(schema, forKey: .schema)
        try container.encode(format, forKey: .format)
        try container.encodeIfPresent(types, forKey: .types)
        try container.encodeIfPresent(explanation, forKey: .explanation)
        try container.encode(creditsUsed, forKey: .creditsUsed)
    }
}

/// Function generation request
public struct FunctionGenerationRequest {
    public let prompt: String
    public let name: String?
    public let runtime: String
    public let includeTypes: Bool

    public init(
        prompt: String,
        name: String? = nil,
        runtime: String = "edge",
        includeTypes: Bool = true
    ) {
        self.prompt = prompt
        self.name = name
        self.runtime = runtime
        self.includeTypes = includeTypes
    }

    func toDict() -> [String: Any] {
        var dict: [String: Any] = [
            "prompt": prompt,
            "runtime": runtime,
            "includeTypes": includeTypes
        ]
        if let name = name { dict["name"] = name }
        return dict
    }
}

/// Function generation result
public struct FunctionGenerationResult: Codable {
    public let code: String
    public let name: String
    public let types: String?
    public let explanation: String?
    public let creditsUsed: Int
}

/// Endpoint generation request
public struct EndpointGenerationRequest {
    public let prompt: String
    public let method: String
    public let path: String?
    public let requiresAuth: Bool
    public let includeValidation: Bool

    public init(
        prompt: String,
        method: String = "GET",
        path: String? = nil,
        requiresAuth: Bool = true,
        includeValidation: Bool = true
    ) {
        self.prompt = prompt
        self.method = method
        self.path = path
        self.requiresAuth = requiresAuth
        self.includeValidation = includeValidation
    }

    func toDict() -> [String: Any] {
        var dict: [String: Any] = [
            "prompt": prompt,
            "method": method,
            "requiresAuth": requiresAuth,
            "includeValidation": includeValidation
        ]
        if let path = path { dict["path"] = path }
        return dict
    }
}

/// Endpoint generation result
public struct EndpointGenerationResult: Codable {
    public let code: String
    public let method: String
    public let path: String
    public let explanation: String?
    public let creditsUsed: Int
}

/// AI chat message
public struct AIChatMessage: Codable {
    public let role: String
    public let content: String

    public init(role: String, content: String) {
        self.role = role
        self.content = content
    }
}

/// AI chat request
public struct AIChatRequest {
    public let messages: [AIChatMessage]
    public let context: [String: Any]?

    public init(messages: [AIChatMessage], context: [String: Any]? = nil) {
        self.messages = messages
        self.context = context
    }

    func toDict() -> [String: Any] {
        var dict: [String: Any] = [
            "messages": messages.map { ["role": $0.role, "content": $0.content] }
        ]
        if let context = context { dict["context"] = context }
        return dict
    }
}

/// AI chat response
public struct AIChatResponse: Codable {
    public let message: AIChatMessage
    public let suggestions: [AISuggestion]?
    public let creditsUsed: Int
}

/// AI suggestion
public struct AISuggestion: Codable {
    public let type: String
    public let title: String
    public let description: String
    public let prompt: String
}

/// AI credits info
public struct AICreditsInfo: Codable {
    public let balance: Int
    public let monthlyAllocation: Int
    public let usedThisMonth: Int
    public let resetDate: String
}

/// AI error
public struct AIError: Error, Sendable, LocalizedError {
    public let message: String
    public let code: String?
    public let status: Int?

    public var errorDescription: String? {
        "AIError\(code.map { " [\($0)]" } ?? ""): \(message)"
    }
}

// MARK: - AI Client

/// AI client for VAIF Studio.
public final class VaifAI {
    private let client: VaifClient

    init(client: VaifClient) {
        self.client = client
    }

    /// Generate database schema from natural language.
    public func generateSchema(
        _ request: SchemaGenerationRequest,
        options: AIGenerateOptions = AIGenerateOptions()
    ) async throws -> (data: SchemaGenerationResult?, error: AIError?) {
        var body = request.toDict()
        body.merge(options.toDict()) { _, new in new }

        let response: ApiResponse<SchemaGenerationResult> = try await client.request(
            path: "/ai/generate/schema",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, AIError(
                message: error.message,
                code: error.code,
                status: response.status
            ))
        }

        return (response.data, nil)
    }

    /// Generate edge function from natural language.
    public func generateFunction(
        _ request: FunctionGenerationRequest,
        options: AIGenerateOptions = AIGenerateOptions()
    ) async throws -> (data: FunctionGenerationResult?, error: AIError?) {
        var body = request.toDict()
        body.merge(options.toDict()) { _, new in new }

        let response: ApiResponse<FunctionGenerationResult> = try await client.request(
            path: "/ai/generate/function",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, AIError(
                message: error.message,
                code: error.code,
                status: response.status
            ))
        }

        return (response.data, nil)
    }

    /// Generate API endpoint from natural language.
    public func generateEndpoint(
        _ request: EndpointGenerationRequest,
        options: AIGenerateOptions = AIGenerateOptions()
    ) async throws -> (data: EndpointGenerationResult?, error: AIError?) {
        var body = request.toDict()
        body.merge(options.toDict()) { _, new in new }

        let response: ApiResponse<EndpointGenerationResult> = try await client.request(
            path: "/ai/generate/endpoint",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, AIError(
                message: error.message,
                code: error.code,
                status: response.status
            ))
        }

        return (response.data, nil)
    }

    /// Chat with AI assistant.
    public func chat(
        _ request: AIChatRequest,
        options: AIGenerateOptions = AIGenerateOptions()
    ) async throws -> (data: AIChatResponse?, error: AIError?) {
        var body = request.toDict()
        body.merge(options.toDict()) { _, new in new }

        let response: ApiResponse<AIChatResponse> = try await client.request(
            path: "/ai/chat",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, AIError(
                message: error.message,
                code: error.code,
                status: response.status
            ))
        }

        return (response.data, nil)
    }

    /// Get AI credits information.
    public func getCredits() async throws -> (data: AICreditsInfo?, error: AIError?) {
        let response: ApiResponse<AICreditsInfo> = try await client.request(
            path: "/ai/credits"
        )

        if let error = response.error {
            return (nil, AIError(
                message: error.message,
                code: error.code,
                status: response.status
            ))
        }

        return (response.data, nil)
    }

    /// Explain code or schema.
    public func explain(
        code: String,
        language: String? = nil,
        context: String? = nil,
        options: AIGenerateOptions = AIGenerateOptions()
    ) async throws -> (data: [String: Any]?, error: AIError?) {
        var body: [String: Any] = ["code": code]
        if let language = language { body["language"] = language }
        if let context = context { body["context"] = context }
        body.merge(options.toDict()) { _, new in new }

        let response: ApiResponse<[String: Any]> = try await client.request(
            path: "/ai/explain",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, AIError(
                message: error.message,
                code: error.code,
                status: response.status
            ))
        }

        return (response.data, nil)
    }

    /// Review code for issues.
    public func review(
        code: String,
        language: String? = nil,
        focus: [String]? = nil,
        options: AIGenerateOptions = AIGenerateOptions()
    ) async throws -> (data: [String: Any]?, error: AIError?) {
        var body: [String: Any] = ["code": code]
        if let language = language { body["language"] = language }
        if let focus = focus { body["focus"] = focus }
        body.merge(options.toDict()) { _, new in new }

        let response: ApiResponse<[String: Any]> = try await client.request(
            path: "/ai/review",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, AIError(
                message: error.message,
                code: error.code,
                status: response.status
            ))
        }

        return (response.data, nil)
    }

    /// Generate TypeScript types from schema.
    public func generateTypes(
        schema: String,
        format: String = "typescript",
        options: AIGenerateOptions = AIGenerateOptions()
    ) async throws -> (data: [String: Any]?, error: AIError?) {
        var body: [String: Any] = ["schema": schema, "format": format]
        body.merge(options.toDict()) { _, new in new }

        let response: ApiResponse<[String: Any]> = try await client.request(
            path: "/ai/generate/types",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, AIError(
                message: error.message,
                code: error.code,
                status: response.status
            ))
        }

        return (response.data, nil)
    }

    /// Generate SQL migration from schema diff.
    public func generateMigration(
        currentSchema: String,
        targetSchema: String,
        database: String = "postgresql",
        options: AIGenerateOptions = AIGenerateOptions()
    ) async throws -> (data: [String: Any]?, error: AIError?) {
        var body: [String: Any] = [
            "currentSchema": currentSchema,
            "targetSchema": targetSchema,
            "database": database
        ]
        body.merge(options.toDict()) { _, new in new }

        let response: ApiResponse<[String: Any]> = try await client.request(
            path: "/ai/generate/migration",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return (nil, AIError(
                message: error.message,
                code: error.code,
                status: response.status
            ))
        }

        return (response.data, nil)
    }
}
