import Leaf
import cmark_swift

public final class Markdown: BasicTag {
    
    public enum Error: Swift.Error {
        case expectedVariable(Argument?)
        case invalidArgument(Argument)
    }
    
    public init() { }
     
    public let name = "markdown"
    
    public func run(arguments: [Argument]) throws -> Node? {
        guard let markdownArgument = arguments.first else {
            throw Error.expectedVariable(arguments.first)
        }
        
        guard let markdown = markdownArgument.value?.string else {
            throw Error.invalidArgument(markdownArgument)
        }
        
        let markdownHtml = try markdownToHTML(markdown)
        
        return .string(markdownHtml)
    }

}
