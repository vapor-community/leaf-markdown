import Vapor

public final class Provider: Vapor.Provider {
    
    public init(config: Config) throws { }
    
    public var provided: Providable {
        let renderer = MarkdownRenderer(viewsDir: "Resources/Views")
        return Providable(view: renderer)
    }

    public func afterInit(_ drop: Droplet) {
        //FIXME: how do I pass the workdir to the renderer?
        (drop.view as! MarkdownRenderer).workDir = drop.workDir
    }
    
    public func beforeServe(_: Droplet) { }
}
