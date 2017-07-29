
final class LeafController {
    
    class func addRoute(builder: RouteBuilder, view: ViewRenderer) {
        
        builder.get("index") { request in
            return try view.make("index", ["content": "sample"])
        }
        
        builder.get("contents") { request in
            
            let context: NodeRepresentable = [
                "posts": [["name": "rb_de0"], ["name": "rb_de1"]],
                "isLike": true,
                "title": "contents",
                "name": "rb_de0"
            ]
            
            return try view.make("contents", context)
        }
    }
}
