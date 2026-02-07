/// VAIF Database Client
///
/// Type-safe database operations with a fluent query builder.

import Foundation

// MARK: - Database Types

/// Query error
public struct QueryError: Error, Sendable, LocalizedError {
    public let message: String
    public let code: String?
    public let details: String?

    public var errorDescription: String? {
        "QueryError\(code.map { " [\($0)]" } ?? ""): \(message)"
    }
}

/// Query result
public struct QueryResult<T> {
    public let data: T?
    public let error: QueryError?
    public let status: Int
    public let count: Int?

    public var isSuccess: Bool { error == nil }
}

// MARK: - Database Client

/// Database client for VAIF Studio.
public final class VaifDatabase {
    private let client: VaifClient

    init(client: VaifClient) {
        self.client = client
    }

    /// Start a query on a table.
    ///
    /// ```swift
    /// let users = try await vaif.db.from("users").select().execute()
    /// ```
    public func from(_ table: String) -> QueryBuilder<[String: Any]> {
        return QueryBuilder(client: client, table: table)
    }

    /// Execute raw SQL query (admin only).
    public func raw<T: Decodable>(
        _ sql: String,
        params: [Any]? = nil
    ) async throws -> QueryResult<[T]> {
        let body: [String: Any] = [
            "sql": sql,
            "params": params ?? []
        ]

        let response: ApiResponse<RawQueryResponse<T>> = try await client.request(
            path: "/db/query",
            method: "POST",
            body: AnyCodable(body)
        )

        if let error = response.error {
            return QueryResult(
                data: nil,
                error: QueryError(
                    message: error.message,
                    code: error.code ?? "QUERY_ERROR",
                    details: nil
                ),
                status: response.status,
                count: nil
            )
        }

        return QueryResult(
            data: response.data?.rows,
            error: nil,
            status: response.status,
            count: nil
        )
    }

    /// Execute a stored procedure/function.
    public func rpc<T: Decodable>(
        _ functionName: String,
        params: [String: Any]? = nil
    ) async throws -> QueryResult<T> {
        let response: ApiResponse<T> = try await client.request(
            path: "/db/rpc/\(functionName)",
            method: "POST",
            body: params != nil ? AnyCodable(params!) : nil
        )

        return QueryResult(
            data: response.data,
            error: response.error.map {
                QueryError(message: $0.message, code: $0.code ?? "RPC_ERROR", details: nil)
            },
            status: response.status,
            count: nil
        )
    }
}

// MARK: - Query Builder

/// Query builder for constructing database queries.
public final class QueryBuilder<T> {
    private let client: VaifClient
    private let table: String
    private var queryType: String = "select"
    private var selectColumns: String = "*"
    private var insertData: Any?
    private var updateData: [String: Any]?
    private var filters: [[String: Any]] = []
    private var orderSpecs: [[String: Any]] = []
    private var limitCount: Int?
    private var offsetCount: Int?
    private var countOption: String?
    private var negateNext: Bool = false

    init(client: VaifClient, table: String) {
        self.client = client
        self.table = table
    }

    /// Select columns.
    @discardableResult
    public func select(_ columns: String = "*") -> Self {
        queryType = "select"
        selectColumns = columns
        return self
    }

    /// Insert data.
    @discardableResult
    public func insert(_ data: Any) -> Self {
        queryType = "insert"
        insertData = data
        return self
    }

    /// Update data.
    @discardableResult
    public func update(_ data: [String: Any]) -> Self {
        queryType = "update"
        updateData = data
        return self
    }

    /// Delete rows.
    @discardableResult
    public func delete() -> Self {
        queryType = "delete"
        return self
    }

    // MARK: - Filter Methods

    @discardableResult
    public func eq(_ column: String, _ value: Any) -> Self {
        addFilter(column, negateNext ? "neq" : "eq", value)
        negateNext = false
        return self
    }

    @discardableResult
    public func neq(_ column: String, _ value: Any) -> Self {
        addFilter(column, negateNext ? "eq" : "neq", value)
        negateNext = false
        return self
    }

    @discardableResult
    public func gt(_ column: String, _ value: Any) -> Self {
        addFilter(column, negateNext ? "lte" : "gt", value)
        negateNext = false
        return self
    }

    @discardableResult
    public func gte(_ column: String, _ value: Any) -> Self {
        addFilter(column, negateNext ? "lt" : "gte", value)
        negateNext = false
        return self
    }

    @discardableResult
    public func lt(_ column: String, _ value: Any) -> Self {
        addFilter(column, negateNext ? "gte" : "lt", value)
        negateNext = false
        return self
    }

    @discardableResult
    public func lte(_ column: String, _ value: Any) -> Self {
        addFilter(column, negateNext ? "gt" : "lte", value)
        negateNext = false
        return self
    }

    @discardableResult
    public func like(_ column: String, _ pattern: String) -> Self {
        addFilter(column, negateNext ? "nlike" : "like", pattern)
        negateNext = false
        return self
    }

    @discardableResult
    public func ilike(_ column: String, _ pattern: String) -> Self {
        addFilter(column, negateNext ? "nilike" : "ilike", pattern)
        negateNext = false
        return self
    }

    @discardableResult
    public func `is`(_ column: String, _ value: Any?) -> Self {
        addFilter(column, negateNext ? "isnot" : "is", value as Any)
        negateNext = false
        return self
    }

    @discardableResult
    public func `in`(_ column: String, _ values: [Any]) -> Self {
        addFilter(column, negateNext ? "nin" : "in", values)
        negateNext = false
        return self
    }

    @discardableResult
    public func contains(_ column: String, _ value: [Any]) -> Self {
        addFilter(column, "cs", value)
        negateNext = false
        return self
    }

    @discardableResult
    public func containedBy(_ column: String, _ value: [Any]) -> Self {
        addFilter(column, "cd", value)
        negateNext = false
        return self
    }

    @discardableResult
    public func overlaps(_ column: String, _ value: [Any]) -> Self {
        addFilter(column, "ov", value)
        negateNext = false
        return self
    }

    @discardableResult
    public func textSearch(_ column: String, _ query: String, config: String? = nil) -> Self {
        addFilter(column, "fts", query, config)
        negateNext = false
        return self
    }

    /// Negate the next filter.
    public var not: Self {
        negateNext = true
        return self
    }

    /// Combine filters with OR.
    @discardableResult
    public func or(_ filters: String) -> Self {
        self.filters.append(["type": "or", "value": filters])
        return self
    }

    /// Order results.
    @discardableResult
    public func order(_ column: String, ascending: Bool = true, nullsFirst: Bool? = nil) -> Self {
        var spec: [String: Any] = ["column": column, "ascending": ascending]
        if let nullsFirst = nullsFirst {
            spec["nullsFirst"] = nullsFirst
        }
        orderSpecs.append(spec)
        return self
    }

    /// Limit results.
    @discardableResult
    public func limit(_ count: Int) -> Self {
        limitCount = count
        return self
    }

    /// Offset results.
    @discardableResult
    public func offset(_ count: Int) -> Self {
        offsetCount = count
        return self
    }

    /// Range of results.
    @discardableResult
    public func range(_ start: Int, _ end: Int) -> Self {
        offsetCount = start
        limitCount = end - start + 1
        return self
    }

    /// Include count in result.
    @discardableResult
    public func count(_ type: String = "exact") -> Self {
        countOption = type
        return self
    }

    /// Return single result.
    public func single<U: Decodable>() async throws -> QueryResult<U> {
        limitCount = 1
        let result: QueryResult<[U]> = try await execute()

        if let error = result.error {
            return QueryResult(data: nil, error: error, status: result.status, count: nil)
        }

        guard let data = result.data, !data.isEmpty else {
            return QueryResult(
                data: nil,
                error: QueryError(message: "No rows returned", code: "PGRST116", details: nil),
                status: 406,
                count: nil
            )
        }

        return QueryResult(data: data.first, error: nil, status: result.status, count: nil)
    }

    /// Return first result or nil.
    public func maybeSingle<U: Decodable>() async throws -> QueryResult<U?> {
        limitCount = 1
        let result: QueryResult<[U]> = try await execute()

        if let error = result.error {
            return QueryResult(data: nil, error: error, status: result.status, count: nil)
        }

        return QueryResult(data: result.data?.first, error: nil, status: result.status, count: nil)
    }

    /// Execute the query.
    public func execute<U: Decodable>() async throws -> QueryResult<[U]> {
        let body = buildQuery()

        let response: ApiResponse<QueryResponse<U>> = try await client.request(
            path: "/db/\(table)",
            method: getHttpMethod(),
            body: AnyCodable(body)
        )

        if let error = response.error {
            return QueryResult(
                data: nil,
                error: QueryError(
                    message: error.message,
                    code: error.code ?? "QUERY_ERROR",
                    details: error.details
                ),
                status: response.status,
                count: nil
            )
        }

        return QueryResult(
            data: response.data?.data,
            error: nil,
            status: response.status,
            count: response.data?.count
        )
    }

    // MARK: - Private Helpers

    private func addFilter(_ column: String, _ op: String, _ value: Any, _ extra: String? = nil) {
        var filter: [String: Any] = [
            "type": "filter",
            "column": column,
            "operator": op,
            "value": value
        ]
        if let extra = extra {
            filter["extra"] = extra
        }
        filters.append(filter)
    }

    private func getHttpMethod() -> String {
        switch queryType {
        case "insert": return "POST"
        case "update": return "PATCH"
        case "delete": return "DELETE"
        default: return "GET"
        }
    }

    private func buildQuery() -> [String: Any] {
        var query: [String: Any] = ["type": queryType]

        if queryType == "select" {
            query["select"] = selectColumns
        }

        if queryType == "insert", let data = insertData {
            query["data"] = data
        }

        if queryType == "update", let data = updateData {
            query["data"] = data
        }

        if !filters.isEmpty {
            query["filters"] = filters
        }

        if !orderSpecs.isEmpty {
            query["order"] = orderSpecs
        }

        if let limit = limitCount {
            query["limit"] = limit
        }

        if let offset = offsetCount {
            query["offset"] = offset
        }

        if let count = countOption {
            query["count"] = count
        }

        return query
    }
}

// MARK: - Helper Types

struct RawQueryResponse<T: Decodable>: Decodable {
    let rows: [T]
}

struct QueryResponse<T: Decodable>: Decodable {
    let data: [T]
    let count: Int?
}

struct AnyCodable: Encodable {
    let value: Any

    init(_ value: Any) {
        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try encodeValue(value, to: &container)
    }

    private func encodeValue(_ value: Any, to container: inout SingleValueEncodingContainer) throws {
        switch value {
        case let v as String:
            try container.encode(v)
        case let v as Int:
            try container.encode(v)
        case let v as Double:
            try container.encode(v)
        case let v as Bool:
            try container.encode(v)
        case let v as [Any]:
            var nestedContainer = container.encoder.unkeyedContainer()
            for item in v {
                try encodeValueToUnkeyed(item, to: &nestedContainer)
            }
        case let v as [String: Any]:
            var nestedContainer = container.encoder.container(keyedBy: DynamicKey.self)
            for (key, val) in v {
                try encodeValueToKeyed(val, forKey: DynamicKey(stringValue: key)!, to: &nestedContainer)
            }
        case is NSNull:
            try container.encodeNil()
        default:
            if let encodable = value as? Encodable {
                try encodable.encode(to: container.encoder)
            }
        }
    }

    private func encodeValueToUnkeyed(_ value: Any, to container: inout UnkeyedEncodingContainer) throws {
        switch value {
        case let v as String:
            try container.encode(v)
        case let v as Int:
            try container.encode(v)
        case let v as Double:
            try container.encode(v)
        case let v as Bool:
            try container.encode(v)
        case let v as [Any]:
            var nested = container.nestedUnkeyedContainer()
            for item in v {
                try encodeValueToUnkeyed(item, to: &nested)
            }
        case let v as [String: Any]:
            try container.encode(AnyCodable(v))
        case is NSNull:
            try container.encodeNil()
        default:
            break
        }
    }

    private func encodeValueToKeyed(_ value: Any, forKey key: DynamicKey, to container: inout KeyedEncodingContainer<DynamicKey>) throws {
        switch value {
        case let v as String:
            try container.encode(v, forKey: key)
        case let v as Int:
            try container.encode(v, forKey: key)
        case let v as Double:
            try container.encode(v, forKey: key)
        case let v as Bool:
            try container.encode(v, forKey: key)
        case let v as [Any]:
            try container.encode(AnyCodable(v), forKey: key)
        case let v as [String: Any]:
            try container.encode(AnyCodable(v), forKey: key)
        case is NSNull:
            try container.encodeNil(forKey: key)
        default:
            break
        }
    }
}

struct DynamicKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}
