import FluentProvider

final class PostController: ResourceRepresentable {
    
    func makeResource() -> Resource<Post> {
        return Resource(
            index: index,
            show: show
        )
    }
    
    func index(_ req: Request) throws -> ResponseRepresentable {
        return try Post.all().makeJSON()
    }
    
    func show(_ req: Request, _ post: Post) throws -> ResponseRepresentable {
        return try post.makeJSON()
    }
}
