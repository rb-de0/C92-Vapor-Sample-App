import FluentProvider

final class FluentController {
    
    class func addRoute(builder: RouteBuilder) {
        
        builder.post("save") { request in
            
            let user = User(username: "rb_de0", password: "hassedPass", age: 22)
            try user.save()
            
            return try user.makeJSON()
        }
        
        builder.get("find") { request in
            
            guard let user = try User.find(1) else {
                throw Abort(.notFound)
            }
            
            return try user.makeJSON()
        }
        
        builder.post("delete") { request in
            
            guard let user = try User.find(1) else {
                throw Abort(.notFound)
            }
            
            try user.delete()
            return try user.makeJSON()
        }
        
        builder.get("filter") { request in
            
            guard let user = try User.makeQuery().filter("age" == 22).filter("name" == "rb_de0").first() else {
                throw Abort(.notFound)
            }
            
            return try user.makeJSON()
        }
    }
}
