import Leaf
import SwiftMarkdown

public final class Markdown: BasicTag {
    
    public enum Error: Swift.Error {
        case invalidArgument(Argument)
    }
    
    public init() { }
     
    public let name = "markdown"
    
    public func run(arguments: [Argument]) throws -> Node? {
        var markdown = ""
        
        if let markdownArgument = arguments.first {
            guard let markdownArgumentValue = markdownArgument.value?.string else {
                throw Error.invalidArgument(markdownArgument)
            }
            markdown = markdownArgumentValue
        }
        
        let markdownHtml = try markdownToHTML(markdown)
        let unescaped = markdownHtml.bytes
        return .bytes(unescaped)
    }

}
