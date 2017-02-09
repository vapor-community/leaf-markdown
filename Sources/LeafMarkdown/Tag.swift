import Leaf
import SwiftMarkdown

public final class Markdown: BasicTag {
    
    public enum Error: Swift.Error {
        case expectedVariable(Argument?)
        case invalidArgument(Argument)
    }
    
    public init() { }
     
    public let name = "LeafMarkdown"
    
    public func run(arguments: [Argument]) throws -> Node? {
        guard let markdownArgument = arguments.first else {
            throw Error.expectedVariable(arguments.first)
        }
        
        guard let markdown = markdownArgument.value?.string else {
            throw Error.invalidArgument(markdownArgument)
        }
        
        let markdownHtml = try markdownToHTML(markdown)
        let unescaped = markdownHtml.bytes
        return .bytes(unescaped)
    }

}
