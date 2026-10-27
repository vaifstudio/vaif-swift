import Foundation
import Testing
@testable import VaifClient

@Suite struct QueryBulkTests {
    @Test func rangeCountAndWildcardSelect() async throws {
        let stub = Stub { _, _ in .json(200, ["data": [["id": "1"]], "count": 37]) }
        let table = try makeClient(stub).from("todos")
        _ = try await table.select("*").range(from: 10, to: 19).list()
        #expect(stub.last.query("limit") == "10" && stub.last.query("offset") == "10")
        #expect(stub.last.query("select") == nil)
        #expect(try await table.eq("done", true).gt("priority", 2).count() == 37)
        #expect(stub.last.query("where") == #"{"AND":[{"field":"done","operator":"eq","value":true},{"field":"priority","operator":"gt","value":2}]}"#)
        #expect(stub.last.query("limit") == "1")
        for bad in [(2, 1), (-1, 3), (0, 1000)] {
            #expect(await vaifError { _ = try await table.range(from: bad.0, to: bad.1).list() }?.kind == .invalidArgument)
        }
        #expect(stub.count == 2)
    }

    @Test func updateManySendsDataAndEqualityFilter() async throws {
        let stub = Stub { _, _ in .json(200, ["data": [["id": "1", "done": true], ["id": "2", "done": true]], "count": 2]) }
        let table = try makeClient(stub).from("todos")
        let result = try await table.eq("list_id", "L1").eq("archived", false).updateMany(["done": true])
        #expect(result.count == 2 && result.data.count == 2)
        #expect(stub.last.method == "PATCH" && stub.last.path == "/v1/data/proj_123/todos/bulk")
        #expect(stub.last.json == ["data": ["done": true], "filter": ["list_id": "L1", "archived": false]])
    }

    @Test func updateManyRefusesFiltersTheBulkRouteWouldDrop() async throws {
        let stub = Stub { _, _ in .status(500) }
        let table = try makeClient(stub).from("todos")
        let cases: [(String, Query, Row)] = [
            ("no filter", table, ["done": true]),
            ("non-eq", table.gt("priority", 1), ["done": true]),
            ("null eq", table.eq("owner_id", Optional<String>.none), ["done": true]),
            ("raw where", table.where(["OR": [["field": "a", "value": 1]]]), ["done": true]),
            ("two eq one column", table.eq("a", 1).eq("a", 2), ["done": true]),
            ("empty data", table.eq("a", 1), [:]),
            ("bad column", table.eq("a", 1), ["bad col": true]),
        ]
        for (name, query, values) in cases {
            let error = await vaifError { _ = try await query.updateMany(values) }
            #expect(error?.kind == .invalidArgument, "\(name)")
        }
        #expect(stub.count == 0)
    }

    @Test func deleteManyEncodesEveryOperatorAsTheServerParsesIt() async throws {
        let stub = Stub { _, _ in .json(200, ["deleted": 3, "ids": ["1", "2", "3"]]) }
        let table = try makeClient(stub).from("todos")
        let deleted = try await table.eq("done", true).neq("pinned", true).lt("priority", 3).gte("age", 1.5)
            .like("title", "a&b%").in("status", ["old", "stale"]).eq("archived_at", Optional<String>.none).deleteMany()
        #expect(deleted == 3)
        #expect(stub.last.method == "DELETE" && stub.last.path == "/v1/data/proj_123/todos/bulk" && stub.last.body.isEmpty)
        #expect(stub.last.query("filter[done.eq]") == "true")
        #expect(stub.last.query("filter[pinned.neq]") == "true")
        #expect(stub.last.query("filter[priority.lt]") == "3")
        #expect(stub.last.query("filter[age.gte]") == "1.5")
        #expect(stub.last.query("filter[title.like]") == "a&b%")
        #expect(stub.last.query("filter[status.in]") == "old,stale")
        #expect(stub.last.query("filter[archived_at.is]") == "null")
        #expect(stub.last.query("where") == nil)
    }

    @Test func deleteManyRefusesUnsafeFilters() async throws {
        let stub = Stub { _, _ in .status(500) }
        let table = try makeClient(stub).from("todos")
        let cases: [(String, Query)] = [
            ("no filter", table),
            ("raw where", table.where(["OR": [["field": "a", "value": 1]]])),
            ("comma in in()", table.in("tag", ["a,b"])),
            ("null in in()", table.in("tag", [Optional<String>.none])),
            ("repeated key", table.eq("a", 1).eq("a", 2)),
            ("null neq", table.neq("a", Optional<String>.none)),
        ]
        for (name, query) in cases {
            #expect(await vaifError { _ = try await query.deleteMany() }?.kind == .invalidArgument, "\(name)")
        }
        #expect(stub.count == 0)
    }
}
