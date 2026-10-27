import Foundation

/// A JSON value. Rows, filter values and error bodies use it.
///
/// Literals work directly: `let row: Row = ["title": "Buy milk", "done": false, "priority": 2]`.
public enum JSONValue: Sendable, Hashable, Codable {
    case null
    case bool(Bool)
    case integer(Int)
    case number(Double)
    case string(String)
    case array([JSONValue])
    case object([String: JSONValue])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(Int.self) {
            self = .integer(value)
        } else if let value = try? container.decode(Double.self) {
            self = .number(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([JSONValue].self) {
            self = .array(value)
        } else {
            self = .object(try container.decode([String: JSONValue].self))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null: try container.encodeNil()
        case let .bool(value): try container.encode(value)
        case let .integer(value): try container.encode(value)
        case let .number(value): try container.encode(value)
        case let .string(value): try container.encode(value)
        case let .array(value): try container.encode(value)
        case let .object(value): try container.encode(value)
        }
    }

    public var stringValue: String? { if case let .string(v) = self { return v } else { return nil } }
    public var boolValue: Bool? { if case let .bool(v) = self { return v } else { return nil } }
    public var intValue: Int? {
        switch self {
        case let .integer(v): return v
        case let .number(v) where v.rounded() == v: return Int(exactly: v)
        default: return nil
        }
    }
    public var doubleValue: Double? {
        switch self {
        case let .integer(v): return Double(v)
        case let .number(v): return v
        default: return nil
        }
    }
    public var arrayValue: [JSONValue]? { if case let .array(v) = self { return v } else { return nil } }
    public var objectValue: [String: JSONValue]? { if case let .object(v) = self { return v } else { return nil } }
    public var isNull: Bool { self == .null }

    public subscript(key: String) -> JSONValue? { objectValue?[key] }

    /// Decode this value into a `Decodable` type. Throws a `.badResponse`
    /// `VaifError` when it does not match.
    public func decode<T: Decodable>(_ type: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        do {
            return try decoder.decode(T.self, from: JSONEncoder().encode(self))
        } catch {
            throw VaifError.decoding(error, as: T.self)
        }
    }
}

extension JSONValue: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) { self = .null }
}

extension JSONValue: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) { self = .bool(value) }
}

extension JSONValue: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) { self = .integer(value) }
}

extension JSONValue: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) { self = .number(value) }
}

extension JSONValue: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) { self = .string(value) }
}

extension JSONValue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: JSONValue...) { self = .array(elements) }
}

extension JSONValue: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, JSONValue)...) {
        self = .object(Dictionary(elements, uniquingKeysWith: { _, last in last }))
    }
}

/// Types that can be used as filter values.
public protocol JSONRepresentable: Sendable {
    var jsonValue: JSONValue { get }
}

extension JSONValue: JSONRepresentable { public var jsonValue: JSONValue { self } }
extension String: JSONRepresentable { public var jsonValue: JSONValue { .string(self) } }
extension Bool: JSONRepresentable { public var jsonValue: JSONValue { .bool(self) } }
extension Int: JSONRepresentable { public var jsonValue: JSONValue { .integer(self) } }
extension Double: JSONRepresentable { public var jsonValue: JSONValue { .number(self) } }
extension UUID: JSONRepresentable { public var jsonValue: JSONValue { .string(uuidString.lowercased()) } }
extension Optional: JSONRepresentable where Wrapped: JSONRepresentable {
    public var jsonValue: JSONValue { self?.jsonValue ?? .null }
}
extension Array: JSONRepresentable where Element: JSONRepresentable {
    public var jsonValue: JSONValue { .array(map(\.jsonValue)) }
}

/// One table row.
public typealias Row = [String: JSONValue]
