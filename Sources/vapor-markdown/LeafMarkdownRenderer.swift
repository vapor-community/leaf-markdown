import Vapor

public final class LeafMarkdownProvider: Vapor.Provider {
    
    public init(config: Config) throws { }
    
    public var provided: Providable {
        //TODO: where can I get the workDir path?
        let root = "/Users/honzadvorsky/Documents/Markdown/vapor-markdown/Resources/Views"
        let leaf = LeafRenderer(viewsDir: root + "/leaf")
        let markdown = MarkdownRenderer(viewsDir: root + "/md")
        leaf.stem.register(Markdown(renderer: markdown))
        return Providable(view: leaf)
    }
    
    public func afterInit(_ drop: Droplet) { }
    public func beforeServe(_: Droplet) { }
}

