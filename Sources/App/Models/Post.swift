import FluentProvider

final class Post: Model {
    
    let storage = Storage()
    let title: String
    let content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    required init(row: Row) throws {
        title = try row.get("title")
        content = try row.get("content")
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("title", title)
        try row.set("content", content)
        return row
    }
}

extension Post: JSONRepresentable {
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("title", title)
        try json.set("content", content)
        return json
    }
}

extension Post: Parameterizable {
    
    static let uniqueSlug = "id"
    
    static func make(for parameter: String) throws -> Post {
        
        guard let post = try Post.find(parameter) else {
            throw Abort(.notFound)
        }
        
        return post
    }
}
