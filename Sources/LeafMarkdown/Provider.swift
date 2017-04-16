import Vapor
import LeafProvider

public struct Provider: Vapor.Provider {
    
    public func boot(_ drop: Droplet) {
        guard let renderer = drop.view as? LeafRenderer else {
            print("LeafMarkdown only supports Leaf as a renderer")
            return
        }
        
        renderer.stem.register(Markdown())
    }
    
    public init(config: Config) throws {}
    public init() {}
    
    public func afterInit(_: Vapor.Droplet) {}
    public func beforeRun(_: Vapor.Droplet) {}
}
