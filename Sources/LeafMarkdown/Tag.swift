import TemplateKit
import SwiftMarkdown

public final class Markdown: TagRenderer {

    public enum Error: Swift.Error {
        case invalidArgument(TemplateData?)
    }

    public let name = "markdown"

    private let options: MarkdownOptions?
 
    public init(options: MarkdownOptions? = nil) {
        self.options = options
    }

    public func render(tag: TagContext) throws -> Future<TemplateData> {

        var markdown = ""

        if let markdownArgument = tag.parameters.first, !markdownArgument.isNil {
            guard let markdownArgumentValue = markdownArgument.string else {
                throw Error.invalidArgument(tag.parameters.first)
            }
            markdown = markdownArgumentValue
        }

        let markdownHTML: String = try {
            if let options = options {
                return try markdownToHTML(markdown, options: options)
            } else {
                return try markdownToHTML(markdown)
            }
        }()

        return Future.map(on: tag) {
            .string(markdownHTML)
        }
    }

}
