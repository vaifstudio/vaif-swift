import Foundation

/// An immutable, chainable query against one table (`/v1/data/:projectId/:table`).
///
/// Builder methods return a new `Query`, so a base query can be shared.
/// Invalid arguments are thrown by the terminal call (`list`, `get`, ...).
public struct Query: Sendable {
    /// The API's cap on `limit`.
    public static let maxLimit = 1000

    private let transport: Transport
    private let auth: AuthClient
    private let projectId: String
    private let table: String
    private var filters: [JSONValue] = []
    private var ordering: [(column: String, descending: Bool)] = []
    private var columns: [String] = []
    private var limitValue: Int?
    private var offsetValue: Int?
    private var error: VaifError?

    init(transport: Transport, auth: AuthClient, projectId: String?, table: String) {
        self.transport = transport
        self.auth = auth
        self.projectId = projectId ?? ""
        self.table = table
        if !Query.isIdentifier(table) {
            error = .invalidArgument("table must be a SQL identifier (letters, digits, _), got \"\(table)\"")
        }
        if projectId == nil { error = VaifError.projectIdRequired("A data query") }
    }

    static func isIdentifier(_ text: String) -> Bool {
        guard let first = text.unicodeScalars.first, first.isASCII,
              CharacterSet.letters.contains(first) || first == "_" else { return false }
        return text.unicodeScalars.allSatisfy {
            $0.isASCII && (CharacterSet.alphanumerics.contains($0) || $0 == "_")
        }
    }

    private func failing(_ message: String) -> Query {
        var copy = self
        if copy.error == nil { copy.error = .invalidArgument(message) }
        return copy
    }

    private func clause(_ column: String, _ op: String, _ value: JSONValue) -> Query {
        guard Query.isIdentifier(column) else { return failing("column must be a SQL identifier, got \"\(column)\"") }
        var copy = self
        copy.filters.append(["field": .string(column), "operator": .string(op), "value": value])
        return copy
    }

    // MARK: Filters (ANDed)

    public func eq(_ column: String, _ value: some JSONRepresentable) -> Query { clause(column, "eq", value.jsonValue) }
    public func neq(_ column: String, _ value: some JSONRepresentable) -> Query { clause(column, "neq", value.jsonValue) }
    public func gt(_ column: String, _ value: some JSONRepresentable) -> Query { clause(column, "gt", value.jsonValue) }
    public func gte(_ column: String, _ value: some JSONRepresentable) -> Query { clause(column, "gte", value.jsonValue) }
    public func lt(_ column: String, _ value: some JSONRepresentable) -> Query { clause(column, "lt", value.jsonValue) }
    public func lte(_ column: String, _ value: some JSONRepresentable) -> Query { clause(column, "lte", value.jsonValue) }
    public func like(_ column: String, _ pattern: String) -> Query { clause(column, "like", .string(pattern)) }
    public func ilike(_ column: String, _ pattern: String) -> Query { clause(column, "ilike", .string(pattern)) }

    public func `in`(_ column: String, _ values: [some JSONRepresentable]) -> Query {
        guard !values.isEmpty else { return failing("in(\"\(column)\") needs at least one value") }
        return clause(column, "in", .array(values.map(\.jsonValue)))
    }

    /// Add a raw clause, ANDed with the others, e.g. an OR group:
    /// `.where(["OR": [["field": "a", "value": 1], ["field": "b", "value": 2]]])`.
    public func `where`(_ clause: JSONValue) -> Query {
        guard case let .object(object) = clause, !object.isEmpty else { return failing("where() needs a non-empty object") }
        var copy = self
        copy.filters.append(clause)
        return copy
    }

    // MARK: Modifiers

    /// Return only these columns (default: all).
    public func select(_ columns: String...) -> Query {
        if columns == ["*"] { var copy = self; copy.columns = []; return copy }
        guard let bad = columns.first(where: { !Query.isIdentifier($0) }) else {
            var copy = self
            copy.columns = columns
            return copy
        }
        return failing("column must be a SQL identifier, got \"\(bad)\"")
    }

    /// Sort by `column`; call again to add secondary sort keys.
    public func order(_ column: String, ascending: Bool = true) -> Query {
        guard Query.isIdentifier(column) else { return failing("column must be a SQL identifier, got \"\(column)\"") }
        var copy = self
        copy.ordering.append((column, !ascending))
        return copy
    }

    public func limit(_ count: Int) -> Query {
        guard (1...Query.maxLimit).contains(count) else { return failing("limit must be between 1 and \(Query.maxLimit)") }
        var copy = self
        copy.limitValue = count
        return copy
    }

    public func offset(_ count: Int) -> Query {
        guard count >= 0 else { return failing("offset must be >= 0") }
        var copy = self
        copy.offsetValue = count
        return copy
    }

    /// Inclusive zero-based range. Like limit/offset, validated at execution.
    public func range(from: Int, to: Int) -> Query {
        guard from >= 0, to >= from, to - from < Self.maxLimit else {
            return failing("range must be nonnegative, ordered and contain at most \(Self.maxLimit) rows")
        }
        return offset(from).limit(to - from + 1)
    }

    // MARK: Serializing

    private func queryItems(limit: Int?, offset: Int?) throws -> [URLQueryItem] {
        var items: [URLQueryItem] = []
        if !filters.isEmpty {
            let tree: JSONValue = filters.count == 1 ? filters[0] : ["AND": .array(filters)]
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
            let data: Data
            do {
                data = try encoder.encode(tree)
            } catch {
                throw VaifError.invalidArgument("could not encode the filters: \(VaifError.describe(error))")
            }
            items.append(URLQueryItem(name: "where", value: String(decoding: data, as: UTF8.self)))
        }
        if !columns.isEmpty { items.append(URLQueryItem(name: "select", value: columns.joined(separator: ","))) }
        if !ordering.isEmpty {
            items.append(URLQueryItem(name: "orderBy", value: ordering.map(\.column).joined(separator: ",")))
            items.append(URLQueryItem(name: "orderDir", value: ordering.map { $0.descending ? "desc" : "asc" }.joined(separator: ",")))
        }
        if let limit { items.append(URLQueryItem(name: "limit", value: String(limit))) }
        if let offset, offset > 0 { items.append(URLQueryItem(name: "offset", value: String(offset))) }
        return items
    }

    private var basePath: String { "/v1/data/\(Transport.escape(projectId))/\(table)" }

    private func rowPath(_ id: String) throws -> String {
        guard !id.isEmpty else { throw VaifError.invalidArgument("id must not be empty") }
        return "\(basePath)/\(Transport.escape(id))"
    }

    private struct ListPayload: Decodable {
        let data: [Row]?
        let count: Int?
    }

    private struct RowPayload: Decodable {
        let data: Row?
    }

    private func send(_ request: HTTPRequest) async throws -> HTTPResponse {
        try await sendAuthorized(request, transport: transport, auth: auth)
    }

    private func fetch(limit: Int?, offset: Int?) async throws -> ListPayload {
        if let error { throw error }
        var request = HTTPRequest(method: "GET", path: basePath)
        request.query = try queryItems(limit: limit, offset: offset)
        return try await send(request).decode(ListPayload.self)
    }

    private func row(_ response: HTTPResponse) throws -> Row {
        guard let row = try response.decode(RowPayload.self).data else {
            throw VaifError(kind: .badResponse, message: "the response did not include a row", status: response.status)
        }
        return row
    }

    // MARK: Terminals

    /// Matching rows plus the total match count.
    public func list() async throws -> ListResult<Row> {
        let payload = try await fetch(limit: limitValue, offset: offsetValue)
        let data = payload.data ?? []
        return ListResult(data: data, count: payload.count ?? data.count)
    }

    /// Total matching rows, ignoring pagination, with the full filter tree.
    public func count() async throws -> Int {
        guard let count = try await fetch(limit: 1, offset: nil).count else {
            throw VaifError(kind: .badResponse, message: "the response did not include a count")
        }
        return count
    }

    /// Matching rows decoded into `T`, plus the total match count.
    public func list<T: Decodable & Sendable>(as type: T.Type, decoder: JSONDecoder = JSONDecoder()) async throws -> ListResult<T> {
        let result = try await list()
        let rows = try result.data.map { try JSONValue.object($0).decode(T.self, decoder: decoder) }
        return ListResult(data: rows, count: result.count)
    }

    /// The first matching row, or nil.
    public func first() async throws -> Row? {
        try await fetch(limit: 1, offset: offsetValue).data?.first
    }

    /// One page of results; `page` starts at 1.
    public func paginate(page: Int, pageSize: Int = 20) async throws -> Page<Row> {
        guard page >= 1 else { throw VaifError.invalidArgument("page must be >= 1") }
        guard (1...Query.maxLimit).contains(pageSize) else {
            throw VaifError.invalidArgument("pageSize must be between 1 and \(Query.maxLimit)")
        }
        let payload = try await fetch(limit: pageSize, offset: (page - 1) * pageSize)
        let data = payload.data ?? []
        return Page(data: data, total: payload.count ?? data.count, page: page, pageSize: pageSize)
    }

    /// One row by primary key; throws `.notFound` when missing.
    public func get(_ id: String) async throws -> Row {
        if let error { throw error }
        var request = HTTPRequest(method: "GET", path: try rowPath(id))
        if !columns.isEmpty { request.query = [URLQueryItem(name: "select", value: columns.joined(separator: ","))] }
        return try row(await send(request))
    }

    /// One row decoded into `T`.
    public func get<T: Decodable>(_ id: String, as type: T.Type, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        try JSONValue.object(await get(id)).decode(T.self, decoder: decoder)
    }

    /// Insert one row (a `Row` or any `Encodable`) and return it.
    @discardableResult
    public func insert(_ values: some Encodable) async throws -> Row {
        if let error { throw error }
        return try row(await send(try .json("POST", basePath, values)))
    }

    /// Insert rows in one request; all rows must share the same keys.
    @discardableResult
    public func insertMany(_ rows: [Row]) async throws -> [Row] {
        if let error { throw error }
        guard !rows.isEmpty else { return [] }
        return try await send(try .json("POST", "\(basePath)/bulk", rows)).decode(ListPayload.self).data ?? []
    }

    /// Insert, or update the row that conflicts on `onConflict` columns.
    @discardableResult
    public func upsert(_ values: Row, onConflict: [String]) async throws -> Row {
        if let error { throw error }
        guard !onConflict.isEmpty else { throw VaifError.invalidArgument("upsert needs at least one conflict column") }
        if let bad = onConflict.first(where: { !Query.isIdentifier($0) }) {
            throw VaifError.invalidArgument("conflict column must be a SQL identifier, got \"\(bad)\"")
        }
        var payload = values
        payload["_upsert"] = true
        payload["_conflict_columns"] = .array(onConflict.map(JSONValue.string))
        return try row(await send(try .json("POST", basePath, payload)))
    }

    /// Update one row by primary key and return it.
    @discardableResult
    public func update(_ id: String, _ values: some Encodable) async throws -> Row {
        if let error { throw error }
        return try row(await send(try .json("PATCH", try rowPath(id), values)))
    }

    /// Delete one row by primary key.
    public func delete(_ id: String) async throws {
        if let error { throw error }
        _ = try await send(HTTPRequest(method: "DELETE", path: try rowPath(id)))
    }

    // MARK: Bulk writes by filter

    private struct Leaf {
        let field: String
        let op: String
        let value: JSONValue
    }

    /// The filters as single-column clauses, or nil if any is a raw `where()` group.
    private func leaves() -> [Leaf]? {
        var result: [Leaf] = []
        for filter in filters {
            guard case let .object(object) = filter, object.count == 3,
                  let field = object["field"]?.stringValue, Query.isIdentifier(field),
                  let op = object["operator"]?.stringValue, let value = object["value"] else { return nil }
            result.append(Leaf(field: field, op: op, value: value))
        }
        return result
    }

    /// A scalar as the bulk routes read it (they compare text parameters).
    private static func text(_ value: JSONValue) -> String? {
        switch value {
        case .string(let text): return text
        case .bool(let flag): return flag ? "true" : "false"
        case .integer(let number): return String(number)
        case .number(let number) where number.isFinite: return String(number)
        default: return nil
        }
    }

    /// Update every row that matches this query's `eq()` filters
    /// (`PATCH /v1/data/:projectId/:table/bulk`) and return them.
    ///
    /// The bulk route matches on equality only, so any other filter, a
    /// `where()` group, a null value or no filter at all is refused before
    /// sending: it would otherwise be dropped by the server and widen the update.
    @discardableResult
    public func updateMany(_ values: Row) async throws -> ListResult<Row> {
        if let error { throw error }
        guard !values.isEmpty else { throw VaifError.invalidArgument("updateMany needs at least one column to set") }
        if let bad = values.keys.sorted().first(where: { !Query.isIdentifier($0) }) {
            throw VaifError.invalidArgument("column must be a SQL identifier, got \"\(bad)\"")
        }
        guard let leaves = leaves(), !leaves.isEmpty else {
            throw VaifError.invalidArgument("updateMany needs at least one eq() filter and no where() groups")
        }
        var filter: Row = [:]
        for leaf in leaves {
            guard leaf.op == "eq", Self.text(leaf.value) != nil else {
                throw VaifError.invalidArgument("updateMany supports only eq() filters with a non-null value; got \(leaf.op) on \"\(leaf.field)\"")
            }
            guard filter[leaf.field] == nil else {
                throw VaifError.invalidArgument("updateMany allows one eq() per column; \"\(leaf.field)\" has two")
            }
            filter[leaf.field] = leaf.value
        }
        let body: Row = ["data": .object(values), "filter": .object(filter)]
        let payload = try await send(try .json("PATCH", "\(basePath)/bulk", body)).decode(ListPayload.self)
        let data = payload.data ?? []
        return ListResult(data: data, count: payload.count ?? data.count)
    }

    /// Delete every row that matches this query's filters
    /// (`DELETE /v1/data/:projectId/:table/bulk`) and return how many.
    ///
    /// Supports eq (including null), neq, gt, gte, lt, lte, like, ilike and
    /// in (values without commas), one per column and operator. A `where()`
    /// group or no filter at all is refused before sending.
    @discardableResult
    public func deleteMany() async throws -> Int {
        if let error { throw error }
        guard let leaves = leaves(), !leaves.isEmpty else {
            throw VaifError.invalidArgument("deleteMany needs at least one filter and no where() groups")
        }
        var items: [URLQueryItem] = []
        var seen = Set<String>()
        for leaf in leaves {
            let key: String
            let value: String
            switch (leaf.op, leaf.value) {
            case ("eq", .null):
                key = "\(leaf.field).is"; value = "null"
            case ("in", .array(let values)):
                let texts = values.compactMap(Self.text)
                guard !texts.isEmpty, texts.count == values.count, !texts.contains(where: { $0.contains(",") }) else {
                    throw VaifError.invalidArgument("deleteMany: in(\"\(leaf.field)\") needs non-null values without commas")
                }
                key = "\(leaf.field).in"; value = texts.joined(separator: ",")
            case (let op, let scalar) where ["eq", "neq", "gt", "gte", "lt", "lte", "like", "ilike"].contains(op):
                guard let text = Self.text(scalar) else {
                    throw VaifError.invalidArgument("deleteMany: \(op)(\"\(leaf.field)\") needs a non-null scalar value")
                }
                key = "\(leaf.field).\(op)"; value = text
            default:
                throw VaifError.invalidArgument("deleteMany does not support \(leaf.op) on \"\(leaf.field)\"")
            }
            // A repeated key reaches the server as an array, which it skips.
            guard seen.insert(key).inserted else {
                throw VaifError.invalidArgument("deleteMany allows one \(leaf.op) filter per column; \"\(leaf.field)\" has two")
            }
            items.append(URLQueryItem(name: "filter[\(key)]", value: value))
        }
        var request = HTTPRequest(method: "DELETE", path: "\(basePath)/bulk")
        request.query = items
        struct Payload: Decodable { let deleted: Int?; let count: Int? }
        let payload = try await send(request).decode(Payload.self)
        return payload.deleted ?? payload.count ?? 0
    }
}
