import Leaf
import SwiftMarkdown

public final class Markdown: Tag {
    
    public enum Error: Swift.Error {
        case invalidArgument(Argument?)
    }
    
    public init() { }
     
    public let name = "markdown"
    
    public func shouldRender(stem: Stem, context: Context, tagTemplate: TagTemplate, arguments: [Argument], value: Node?) -> Bool{
        return true
    }
    
    public func run(tagTemplate: TagTemplate, arguments: ArgumentList) throws -> Node? {
        var markdown = ""
        
        if let markdownArgument = arguments.first {
            guard let markdownArgumentValue = markdownArgument.string else {
                throw Error.invalidArgument(arguments.list.first)
            }
            markdown = markdownArgumentValue
        }
        
        let markdownHtml = try markdownToHTML(markdown)
        let unescaped = markdownHtml.bytes
        return .bytes(unescaped)
    }

}
