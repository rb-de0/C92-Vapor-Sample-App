import FluentProvider
import AuthProvider

final class User: Model {
    
    let storage = Storage()
    let username: String
    let password: String
    let age: Int
    
    init(password: Password) {
        self.username = password.username
        self.password = password.password
        self.age = 22
    }
    
    init(username: String, password: String, age: Int) {
        self.username = username
        self.password = password
        self.age = age
    }
    
    required init(row: Row) throws {
        username = try row.get("name")
        password = try row.get("password")
        age = try row.get("age")
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("name", username)
        try row.set("password", password)
        try row.set("age", age)
        return row
    }
}

extension User: JSONRepresentable {
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("name", username)
        try json.set("age", age)
        return json
    }
}

extension User: Preparation {
    
    static func prepare(_ database: Database) throws {
        
        try database.create(self) { users in
            users.id()
            users.string("name")
            users.string("password")
            users.int("age")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

// MARK: - PasswordAuthenticatable
extension User: PasswordAuthenticatable {
    
    static var usernameKey: String {
        return "name"
    }
}

extension User: SessionPersistable {}
