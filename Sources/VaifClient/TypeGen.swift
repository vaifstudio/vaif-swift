/// VAIF Type Generator
///
/// Generate Swift types from database schema.

import Foundation

// MARK: - Schema Types

/// Column schema definition.
public struct ColumnSchema: Codable {
    public let name: String
    public let type: String
    public let nullable: Bool
    public let defaultValue: String?
    public let isPrimaryKey: Bool
    public let isForeignKey: Bool
    public let foreignTable: String?
    public let foreignColumn: String?
    public let isUnique: Bool
    public let comment: String?

    enum CodingKeys: String, CodingKey {
        case name, type, nullable
        case defaultValue = "defaultValue"
        case isPrimaryKey = "isPrimaryKey"
        case isForeignKey = "isForeignKey"
        case foreignTable = "foreignTable"
        case foreignColumn = "foreignColumn"
        case isUnique = "isUnique"
        case comment
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        nullable = try container.decodeIfPresent(Bool.self, forKey: .nullable) ?? true
        defaultValue = try container.decodeIfPresent(String.self, forKey: .defaultValue)
        isPrimaryKey = try container.decodeIfPresent(Bool.self, forKey: .isPrimaryKey) ?? false
        isForeignKey = try container.decodeIfPresent(Bool.self, forKey: .isForeignKey) ?? false
        foreignTable = try container.decodeIfPresent(String.self, forKey: .foreignTable)
        foreignColumn = try container.decodeIfPresent(String.self, forKey: .foreignColumn)
        isUnique = try container.decodeIfPresent(Bool.self, forKey: .isUnique) ?? false
        comment = try container.decodeIfPresent(String.self, forKey: .comment)
    }
}

/// Foreign key schema.
public struct ForeignKeySchema: Codable {
    public let name: String
    public let columns: [String]
    public let foreignTable: String
    public let foreignColumns: [String]
    public let onDelete: String
    public let onUpdate: String

    enum CodingKeys: String, CodingKey {
        case name, columns
        case foreignTable = "foreignTable"
        case foreignColumns = "foreignColumns"
        case onDelete = "onDelete"
        case onUpdate = "onUpdate"
    }
}

/// Index schema.
public struct IndexSchema: Codable {
    public let name: String
    public let columns: [String]
    public let unique: Bool
    public let type: String
}

/// Table schema.
public struct TableSchema: Codable {
    public let name: String
    public let schema: String
    public let columns: [ColumnSchema]
    public let primaryKey: [String]
    public let foreignKeys: [ForeignKeySchema]
    public let indexes: [IndexSchema]
    public let comment: String?
}

/// Enum schema.
public struct EnumSchema: Codable {
    public let name: String
    public let schema: String
    public let values: [String]
}

/// View schema.
public struct ViewSchema: Codable {
    public let name: String
    public let schema: String
    public let columns: [ColumnSchema]
}

/// Complete database schema.
public struct DatabaseSchema: Codable {
    public let tables: [TableSchema]
    public let enums: [EnumSchema]
    public let views: [ViewSchema]
}

// MARK: - Type Generation Options

/// Type generation options.
public struct TypeGenOptions {
    /// Include Row types (for SELECT).
    public var includeRow: Bool = true

    /// Include Insert types (for INSERT).
    public var includeInsert: Bool = true

    /// Include Update types (for UPDATE).
    public var includeUpdate: Bool = true

    /// Include relationships.
    public var includeRelationships: Bool = true

    /// Schema to generate types for.
    public var schema: String = "public"

    /// Tables to include (all if empty).
    public var tables: [String]? = nil

    /// Tables to exclude.
    public var excludeTables: [String]? = nil

    /// Add doc comments.
    public var includeComments: Bool = true

    /// Generate Codable conformance.
    public var includeCodable: Bool = true

    /// Generate Sendable conformance.
    public var includeSendable: Bool = true

    /// Generate Equatable conformance.
    public var includeEquatable: Bool = true

    /// Generate Hashable conformance.
    public var includeHashable: Bool = false

    public init(
        includeRow: Bool = true,
        includeInsert: Bool = true,
        includeUpdate: Bool = true,
        includeRelationships: Bool = true,
        schema: String = "public",
        tables: [String]? = nil,
        excludeTables: [String]? = nil,
        includeComments: Bool = true,
        includeCodable: Bool = true,
        includeSendable: Bool = true,
        includeEquatable: Bool = true,
        includeHashable: Bool = false
    ) {
        self.includeRow = includeRow
        self.includeInsert = includeInsert
        self.includeUpdate = includeUpdate
        self.includeRelationships = includeRelationships
        self.schema = schema
        self.tables = tables
        self.excludeTables = excludeTables
        self.includeComments = includeComments
        self.includeCodable = includeCodable
        self.includeSendable = includeSendable
        self.includeEquatable = includeEquatable
        self.includeHashable = includeHashable
    }
}

// MARK: - PostgreSQL to Swift Type Mapping

private let pgToSwiftTypes: [String: String] = [
    // Numeric
    "smallint": "Int16",
    "integer": "Int",
    "bigint": "Int64",
    "int2": "Int16",
    "int4": "Int",
    "int8": "Int64",
    "decimal": "Decimal",
    "numeric": "Decimal",
    "real": "Float",
    "double precision": "Double",
    "float4": "Float",
    "float8": "Double",
    "serial": "Int",
    "bigserial": "Int64",
    "smallserial": "Int16",
    "money": "Decimal",

    // String
    "character": "String",
    "character varying": "String",
    "varchar": "String",
    "char": "String",
    "text": "String",
    "name": "String",
    "citext": "String",

    // Boolean
    "boolean": "Bool",
    "bool": "Bool",

    // Date/Time
    "date": "Date",
    "time": "String",
    "time with time zone": "String",
    "time without time zone": "String",
    "timestamp": "Date",
    "timestamp with time zone": "Date",
    "timestamp without time zone": "Date",
    "timestamptz": "Date",
    "timetz": "String",
    "interval": "String",

    // Binary
    "bytea": "Data",

    // UUID
    "uuid": "UUID",

    // JSON
    "json": "[String: Any]",
    "jsonb": "[String: Any]",

    // Network
    "inet": "String",
    "cidr": "String",
    "macaddr": "String",
    "macaddr8": "String",

    // Other
    "xml": "String",
    "void": "Void",
    "unknown": "Any",
]

// MARK: - Type Generator

/// VAIF Type Generator for Swift.
public final class VaifTypeGen {
    private let client: VaifClient

    init(client: VaifClient) {
        self.client = client
    }

    /// Fetch database schema from the API.
    public func fetchSchema(_ schema: String = "public") async throws -> DatabaseSchema {
        let response: ApiResponse<DatabaseSchema> = try await client.request(
            path: "/database/schema?schema=\(schema)"
        )

        if let error = response.error {
            throw NSError(domain: "VaifTypeGen", code: -1, userInfo: [
                NSLocalizedDescriptionKey: error.message
            ])
        }

        return response.data!
    }

    /// Generate Swift types from schema.
    public func generate(options: TypeGenOptions = TypeGenOptions()) async throws -> String {
        let dbSchema = try await fetchSchema(options.schema)
        return generateFromSchema(dbSchema, options: options)
    }

    /// Generate Swift types from schema directly.
    public func generateFromSchema(
        _ schema: DatabaseSchema,
        options: TypeGenOptions = TypeGenOptions()
    ) -> String {
        var lines: [String] = []

        // Header
        lines.append("/// VAIF Studio Database Types")
        lines.append("/// Generated at \(ISO8601DateFormatter().string(from: Date()))")
        lines.append("/// DO NOT EDIT - This file is auto-generated")
        lines.append("")
        lines.append("import Foundation")
        lines.append("")

        // Generate enums
        if !schema.enums.isEmpty {
            lines.append("// MARK: - Enums")
            lines.append("")
            for enumDef in schema.enums {
                lines.append(contentsOf: generateEnum(enumDef, options: options))
                lines.append("")
            }
        }

        // Filter tables
        let tables = options.tables ?? []
        let excludeTables = options.excludeTables ?? []

        let filteredTables = schema.tables.filter { table in
            if !tables.isEmpty && !tables.contains(table.name) { return false }
            if excludeTables.contains(table.name) { return false }
            return true
        }

        // Generate table types
        lines.append("// MARK: - Tables")
        lines.append("")

        for table in filteredTables {
            lines.append(contentsOf: generateTableTypes(table, allTables: schema.tables, options: options))
            lines.append("")
        }

        // Generate view types
        if !schema.views.isEmpty {
            lines.append("// MARK: - Views")
            lines.append("")
            for view in schema.views {
                if !tables.isEmpty && !tables.contains(view.name) { continue }
                if excludeTables.contains(view.name) { continue }
                lines.append(contentsOf: generateViewType(view, options: options))
                lines.append("")
            }
        }

        return lines.joined(separator: "\n")
    }

    private func generateEnum(_ enumDef: EnumSchema, options: TypeGenOptions) -> [String] {
        var lines: [String] = []
        let typeName = toPascalCase(enumDef.name)

        var conformances: [String] = ["String"]
        if options.includeCodable { conformances.append("Codable") }
        if options.includeSendable { conformances.append("Sendable") }

        if options.includeComments {
            lines.append("/// Enum: \(enumDef.name)")
        }
        lines.append("public enum \(typeName): \(conformances.joined(separator: ", ")) {")

        for value in enumDef.values {
            let caseName = toCamelCase(value)
            lines.append("    case \(caseName) = \"\(value)\"")
        }

        lines.append("}")

        return lines
    }

    private func generateTableTypes(
        _ table: TableSchema,
        allTables: [TableSchema],
        options: TypeGenOptions
    ) -> [String] {
        var lines: [String] = []
        let typeName = toPascalCase(table.name)

        // Row type (SELECT)
        if options.includeRow {
            lines.append(contentsOf: generateStruct(
                name: "\(typeName)Row",
                columns: table.columns,
                comment: table.comment,
                options: options,
                includeAll: true,
                relationships: options.includeRelationships ? table.foreignKeys : nil,
                allTables: allTables
            ))
            lines.append("")
        }

        // Insert type
        if options.includeInsert {
            lines.append(contentsOf: generateStruct(
                name: "\(typeName)Insert",
                columns: table.columns,
                comment: "Insert model for \(table.name)",
                options: options,
                includeAll: false,
                makeOptionalWithDefaults: true
            ))
            lines.append("")
        }

        // Update type
        if options.includeUpdate {
            let updateColumns = table.columns.filter { !$0.isPrimaryKey }
            lines.append(contentsOf: generateStruct(
                name: "\(typeName)Update",
                columns: updateColumns,
                comment: "Update model for \(table.name)",
                options: options,
                includeAll: true,
                allOptional: true
            ))
        }

        return lines
    }

    private func generateStruct(
        name: String,
        columns: [ColumnSchema],
        comment: String?,
        options: TypeGenOptions,
        includeAll: Bool = true,
        makeOptionalWithDefaults: Bool = false,
        allOptional: Bool = false,
        relationships: [ForeignKeySchema]? = nil,
        allTables: [TableSchema]? = nil
    ) -> [String] {
        var lines: [String] = []

        // Build conformances
        var conformances: [String] = []
        if options.includeCodable { conformances.append("Codable") }
        if options.includeSendable { conformances.append("Sendable") }
        if options.includeEquatable { conformances.append("Equatable") }
        if options.includeHashable { conformances.append("Hashable") }

        let conformanceStr = conformances.isEmpty ? "" : ": \(conformances.joined(separator: ", "))"

        if options.includeComments, let comment = comment {
            lines.append("/// \(comment)")
        }
        lines.append("public struct \(name)\(conformanceStr) {")

        // Properties
        for col in columns {
            let swiftType = pgTypeToSwift(col.type)
            let isOptional = col.nullable || allOptional ||
                (makeOptionalWithDefaults && (col.defaultValue != nil || col.isPrimaryKey))

            let typeStr = isOptional ? "\(swiftType)?" : swiftType
            let propName = toCamelCase(col.name)

            if options.includeComments, let comment = col.comment {
                lines.append("    /// \(comment)")
            }
            lines.append("    public let \(propName): \(typeStr)")
        }

        // Relationship properties
        if let relationships = relationships, let allTables = allTables {
            for fk in relationships {
                if allTables.contains(where: { $0.name == fk.foreignTable }) {
                    let relatedType = toPascalCase(fk.foreignTable)
                    let propName = toCamelCase(fk.foreignTable)
                    lines.append("    public let \(propName): \(relatedType)Row?")
                }
            }
        }

        lines.append("")

        // Init
        lines.append("    public init(")
        var initParams: [String] = []
        for col in columns {
            let swiftType = pgTypeToSwift(col.type)
            let isOptional = col.nullable || allOptional ||
                (makeOptionalWithDefaults && (col.defaultValue != nil || col.isPrimaryKey))

            let typeStr = isOptional ? "\(swiftType)?" : swiftType
            let propName = toCamelCase(col.name)
            let defaultVal = isOptional ? " = nil" : ""

            initParams.append("        \(propName): \(typeStr)\(defaultVal)")
        }

        if let relationships = relationships, let allTables = allTables {
            for fk in relationships {
                if allTables.contains(where: { $0.name == fk.foreignTable }) {
                    let relatedType = toPascalCase(fk.foreignTable)
                    let propName = toCamelCase(fk.foreignTable)
                    initParams.append("        \(propName): \(relatedType)Row? = nil")
                }
            }
        }

        lines.append(initParams.joined(separator: ",\n"))
        lines.append("    ) {")

        for col in columns {
            let propName = toCamelCase(col.name)
            lines.append("        self.\(propName) = \(propName)")
        }

        if let relationships = relationships, let allTables = allTables {
            for fk in relationships {
                if allTables.contains(where: { $0.name == fk.foreignTable }) {
                    let propName = toCamelCase(fk.foreignTable)
                    lines.append("        self.\(propName) = \(propName)")
                }
            }
        }

        lines.append("    }")

        // CodingKeys for snake_case mapping
        if options.includeCodable {
            lines.append("")
            lines.append("    enum CodingKeys: String, CodingKey {")
            for col in columns {
                let propName = toCamelCase(col.name)
                if propName != col.name {
                    lines.append("        case \(propName) = \"\(col.name)\"")
                } else {
                    lines.append("        case \(propName)")
                }
            }
            if let relationships = relationships, let allTables = allTables {
                for fk in relationships {
                    if allTables.contains(where: { $0.name == fk.foreignTable }) {
                        let propName = toCamelCase(fk.foreignTable)
                        if propName != fk.foreignTable {
                            lines.append("        case \(propName) = \"\(fk.foreignTable)\"")
                        } else {
                            lines.append("        case \(propName)")
                        }
                    }
                }
            }
            lines.append("    }")
        }

        lines.append("}")

        return lines
    }

    private func generateViewType(_ view: ViewSchema, options: TypeGenOptions) -> [String] {
        return generateStruct(
            name: "\(toPascalCase(view.name))Row",
            columns: view.columns,
            comment: "View: \(view.name)",
            options: options,
            includeAll: true
        )
    }

    private func pgTypeToSwift(_ pgType: String) -> String {
        // Handle arrays
        if pgType.hasSuffix("[]") {
            let baseType = String(pgType.dropLast(2))
            let swiftBaseType = pgToSwiftTypes[baseType.lowercased()] ?? "Any"
            return "[\(swiftBaseType)]"
        }

        // Handle ARRAY type
        let arrayPattern = try? NSRegularExpression(pattern: "^(.+)\\s+ARRAY$", options: .caseInsensitive)
        if let match = arrayPattern?.firstMatch(
            in: pgType,
            options: [],
            range: NSRange(location: 0, length: pgType.utf16.count)
        ), let range = Range(match.range(at: 1), in: pgType) {
            let baseType = String(pgType[range])
            let swiftBaseType = pgToSwiftTypes[baseType.lowercased()] ?? "Any"
            return "[\(swiftBaseType)]"
        }

        // Handle with precision (e.g., numeric(10,2))
        let precisionPattern = try? NSRegularExpression(pattern: "^(\\w+)\\(", options: [])
        if let match = precisionPattern?.firstMatch(
            in: pgType,
            options: [],
            range: NSRange(location: 0, length: pgType.utf16.count)
        ), let range = Range(match.range(at: 1), in: pgType) {
            let baseType = String(pgType[range])
            return pgToSwiftTypes[baseType.lowercased()] ?? "Any"
        }

        return pgToSwiftTypes[pgType.lowercased()] ?? "Any"
    }

    private func toPascalCase(_ str: String) -> String {
        let parts = str.components(separatedBy: CharacterSet(charactersIn: "_- "))
        return parts.map { part in
            guard !part.isEmpty else { return "" }
            return part.prefix(1).uppercased() + part.dropFirst().lowercased()
        }.joined()
    }

    private func toCamelCase(_ str: String) -> String {
        let pascal = toPascalCase(str)
        guard !pascal.isEmpty else { return pascal }
        return pascal.prefix(1).lowercased() + pascal.dropFirst()
    }
}

/// Create a type generator instance.
public func createTypeGen(client: VaifClient) -> VaifTypeGen {
    return VaifTypeGen(client: client)
}
