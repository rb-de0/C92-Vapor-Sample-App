import AuthProvider

final class LoginController: ResourceRepresentable {
    
    let view: ViewRenderer
    let hash: HashProtocol
    
    init(view: ViewRenderer, hash: HashProtocol) {
        self.view = view
        self.hash = hash
    }
    
    func makeResource() -> Resource<String>{
        return Resource(
            index: index,
            store: store
        )
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try view.make("login")
    }
    
    func store(request: Request) throws -> ResponseRepresentable {
        let credential = try request.userNamePassword(hash: hash)
        let user = try User.authenticate(credential)
        request.auth.authenticate(user)
        return try user.makeJSON()
    }
}
