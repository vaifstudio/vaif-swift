import Foundation
import Testing
@testable import VaifClient

@Suite struct DataTests {
    @Test func listSerializesFiltersOrderSelectAndPaging() async throws {
        let stub = Stub { _, _ in .json(200, ["data": [["id": "1"]], "count": 42]) }
        let result = try await makeClient(stub).from("todos")
            .select("id", "title")
            .eq("done", false)
            .gte("priority", 2)
            .in("tag", ["a", "b"])
            .order("created_at", ascending: false)
            .order("id")
            .limit(10)
            .offset(20)
            .list()
        let request = stub.last
        #expect(request.path == "/v1/data/proj_123/todos")
        let whereValue = try JSONDecoder().decode(JSONValue.self, from: Data(request.query("where")!.utf8))
        let expected: JSONValue = ["AND": [
            ["field": "done", "operator": "eq", "value": false],
            ["field": "priority", "operator": "gte", "value": 2],
            ["field": "tag", "operator": "in", "value": ["a", "b"]],
        ]]
        #expect(whereValue == expected)
        #expect(request.query("select") == "id,title")
        #expect(request.query("orderBy") == "created_at,id")
        #expect(request.query("orderDir") == "desc,asc")
        #expect(request.query("limit") == "10")
        #expect(request.query("offset") == "20")
        #expect(result.count == 42)
        #expect(result.data.count == 1)
    }

    @Test func singleFilterAndRawWhere() async throws {
        let stub = Stub { _, _ in emptyList }
        let client = try makeClient(stub)
        _ = try await client.from("todos").ilike("title", "%milk+eggs%").list()
        let single = try JSONDecoder().decode(JSONValue.self, from: Data(stub.last.query("where")!.utf8))
        #expect(single == ["field": "title", "operator": "ilike", "value": "%milk+eggs%"])
        let or: JSONValue = ["OR": [["field": "a", "value": 1], ["field": "b", "value": 2]]]
        _ = try await client.from("todos").where(or).list()
        let raw = try JSONDecoder().decode(JSONValue.self, from: Data(stub.last.query("where")!.utf8))
        #expect(raw == or)
    }

    @Test func builderErrorsAreThrownWithoutNetwork() async throws {
        let stub = Stub { _, _ in emptyList }
        let client = try makeClient(stub)
        let queries = [
            client.from("todos; drop"),
            client.from("todos").eq("a b", 1),
            client.from("todos").limit(1001),
            client.from("todos").in("id", [String]()),
            client.from("todos").offset(-1),
        ]
        for query in queries {
            let error = await vaifError { _ = try await query.list() }
            #expect(error?.kind == .invalidArgument)
        }
        #expect(stub.count == 0)
    }

    @Test func builderIsImmutable() async throws {
        let stub = Stub { _, _ in emptyList }
        let base = try makeClient(stub).from("todos").eq("done", false)
        _ = base.eq("owner", "u1")
        _ = try await base.list()
        #expect(!(stub.last.query("where") ?? "").contains("owner"))
    }

    @Test func paginateAndFirst() async throws {
        let stub = Stub { request, _ in
            if request.query("limit") == "1" { return emptyList }
            return .json(200, ["data": .array(Array(repeating: ["id": 1], count: 10)), "count": 25])
        }
        let client = try makeClient(stub)
        let page = try await client.from("todos").paginate(page: 2, pageSize: 10)
        #expect(stub.last.query("limit") == "10")
        #expect(stub.last.query("offset") == "10")
        #expect(page.total == 25 && page.pageCount == 3 && page.hasNext && page.hasPrevious)
        #expect(try await client.from("todos").first() == nil)
    }

    @Test func crudPathsMethodsAndBodies() async throws {
        let stub = Stub { request, _ in
            if request.method == "POST", request.path.hasSuffix("/bulk") {
                return .json(200, ["data": [["id": 1], ["id": 2]], "count": 2])
            }
            if request.method == "DELETE" { return .json(200, ["data": ["id": "n1"], "deleted": true]) }
            return .json(200, ["data": ["id": "n1", "title": "x"]])
        }
        let todos = try makeClient(stub).from("todos")
        _ = try await todos.get("a/b")
        #expect(stub.last.rawPath == "/v1/data/proj_123/todos/a%2Fb")
        let created = try await todos.insert(["title": "x"] as Row)
        #expect(created["id"] == "n1")
        #expect(stub.last.json == ["title": "x"])
        _ = try await todos.update("n1", ["title": "y"] as Row)
        #expect(stub.last.method == "PATCH" && stub.last.path == "/v1/data/proj_123/todos/n1")
        try await todos.delete("n1")
        #expect(stub.last.method == "DELETE")
        let many = try await todos.insertMany([["title": "a"], ["title": "b"]])
        #expect(many.count == 2)
        #expect(stub.last.json == [["title": "a"], ["title": "b"]])
        _ = try await todos.upsert(["email": "a@b.c"], onConflict: ["email"])
        #expect(stub.last.json == ["email": "a@b.c", "_upsert": true, "_conflict_columns": ["email"]])

        struct Todo: Codable, Sendable { let id: String; let title: String }
        let typed = try await todos.get("n1", as: Todo.self)
        #expect(typed.title == "x")
        _ = try await todos.insert(Todo(id: "t", title: "encodable"))
        #expect(stub.last.json == ["id": "t", "title": "encodable"])
    }

    @Test func typedListDecodes() async throws {
        struct Item: Decodable, Sendable { let id: Int; let name: String }
        let stub = Stub { _, _ in .json(200, ["data": [["id": 1, "name": "a"]], "count": 1]) }
        let items = try await makeClient(stub).from("items").list(as: Item.self)
        #expect(items.data.first?.name == "a" && items.count == 1)
    }

    /// Every error the SDK throws is a `VaifError`, including a row that does
    /// not decode as the requested type.
    @Test func aRowThatDoesNotDecodeIsABadResponse() async throws {
        struct Todo: Decodable, Sendable { let id: String; let done: Bool }
        let stub = Stub { request, _ in
            request.path.hasSuffix("/n1")
                ? .json(200, ["data": ["id": "n1", "done": "yes"]])
                : .json(200, ["data": [["id": "n1"]], "count": 1])
        }
        let todos = try makeClient(stub).from("todos")
        let listed = await vaifError { _ = try await todos.list(as: Todo.self) }
        #expect(listed?.kind == .badResponse)
        #expect(listed?.message == "the value does not decode as Todo: missing key done")
        let got = await vaifError { _ = try await todos.get("n1", as: Todo.self) }
        #expect(got?.kind == .badResponse)
        #expect(got?.message == "the value does not decode as Todo: expected Bool at done")
        let direct = await vaifError { _ = try JSONValue.array([1, 2]).decode([String].self) }
        #expect(direct?.message == "the value does not decode as Array<String>: expected String at 0")
    }

    @Test func aFilterValueThatCannotBeEncodedIsRefusedBeforeSending() async throws {
        let stub = Stub { _, _ in emptyList }
        let error = await vaifError { _ = try await makeClient(stub).from("readings").gt("value", Double.infinity).list() }
        #expect(error?.kind == .invalidArgument)
        #expect(stub.count == 0)
    }

    @Test func malformedSuccessBodyIsBadResponse() async throws {
        let stub = Stub { _, _ in Reply(status: 200, body: Data("<html>".utf8)) }
        let error = await vaifError { try await makeClient(stub).from("todos").insert(["title": "x"] as Row) }
        #expect(error?.kind == .badResponse)
    }
}
