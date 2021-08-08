import LeafKit
import SwiftMarkdown

public struct Markdown: UnsafeUnescapedLeafTag {
    public enum Error: Swift.Error {
        case invalidArgument(LeafData?)
    }
    
    private let options: MarkdownOptions?
    
    public init(options: MarkdownOptions? = nil) {
        self.options = options
    }
    
    public func render(_ ctx: LeafContext) throws -> LeafData {
        var markdown = ""
        
        if let markdownArgument = ctx.parameters.first, !markdownArgument.isNil {
            guard let markdownArgumentValue = markdownArgument.string else {
                throw Error.invalidArgument(ctx.parameters.first)
            }
            markdown = markdownArgumentValue
        }

        let markdownHTML: String
        if let options = options {
            markdownHTML = try markdownToHTML(markdown, options: options)
        } else {
            markdownHTML = try markdownToHTML(markdown)
        }

        return .string(markdownHTML)
    }
}
