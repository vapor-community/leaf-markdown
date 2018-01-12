import Vapor
import Leaf

public struct Provider: Vapor.Provider {

    public static let repositoryName = "markdown-provider"

    public func register(_ services: inout Services) throws {
        var tags = LeafTagConfig.default()
        tags.use(Markdown(), as: "markdown")
        services.register(tags)
    }

    public func boot(_ worker: Container) throws {
        do {
            _ = try worker.make(LeafRenderer.self, for: TemplateRenderer.self)
        } catch is ServiceError {
            print("Markdown Provider only supports Leaf as a renderer - make sure the Leaf Provider has been registered")
        }
    }
//
//    public func boot(_ drop: Droplet) {
//        guard let renderer = drop.view as? LeafRenderer else {
//            print("Markdown Provider only supports Leaf as a renderer")
//            return
//        }
//
//        renderer.stem.register(Markdown())
//    }
}
