
final class RoutingController {
    
    class func addRoute(builder: RouteBuilder) {
        
        builder.get("welcome") { request in
            return "Hello"
        }
        
        builder.post("post") { request in
            return "Hello POST Request"
        }
        
        builder.get("json") { request in
            var json = JSON()
            try json.set("value", 1007)
            return json
        }
        
        builder.get("404") { request in
            throw Abort(.notFound)
        }
        
        builder.get("page") { request in
            let page = request.query?["page"]?.int ?? 0
            return "Query parameter is \(page)"
        }
        
        builder.post("content") { request in
            let data = request.data["data"]?.string ?? ""
            return "Body Data is \(data)"
        }
        
        builder.get("header") { request in
            let header = request.headers["data"]?.string ?? ""
            return "Header Data is \(header)"
        }
        
        builder.get("post", Post.parameter) { request in
            let post = try request.parameters.next(Post.self)
            return try post.makeJSON()
        }
        
        builder.resource("/posts", PostController())
    }
}
