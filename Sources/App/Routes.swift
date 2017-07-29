import FluentProvider
import AuthProvider

final class Routes: RouteCollection {
    
    private let view: ViewRenderer
    private let hash: HashProtocol
    
    init(view: ViewRenderer, hash: HashProtocol) {
        self.view = view
        self.hash = hash
    }
    
    func build(_ builder: RouteBuilder) throws {
        
        RoutingController.addRoute(builder: builder)
        FluentController.addRoute(builder: builder)
        LeafController.addRoute(builder: builder, view: view)
        
        builder.resource("users", UserController(hash: hash))
        builder.resource("login", LoginController(view: view, hash: hash))
        
        let secureGroup = builder.grouped(PasswordAuthenticationMiddleware(User.self))
        secureGroup.get("auth") { request in
            return try request.auth.assertAuthenticated(User.self).makeJSON()
        }
    }
}

final class EmptyInitializableRoutes: RouteCollection, EmptyInitializable {
    
    func build(_ builder: RouteBuilder) throws {}
}

