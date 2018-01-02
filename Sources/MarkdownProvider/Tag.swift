import Leaf
import SwiftMarkdown
import Async

public final class Markdown: LeafTag {

    public enum Error: Swift.Error {
        case invalidArgument(LeafData?)
    }

    public let name = "markdown"

    public func render(parsed: ParsedTag, context: LeafContext, renderer: LeafRenderer) throws -> Future<LeafData?> {

        var markdown = ""

        if let markdownArgument = parsed.parameters.first, !markdownArgument.isNull {
            guard let markdownArgumentValue = markdownArgument.string else {
                throw Error.invalidArgument(parsed.parameters.first)
            }
            markdown = markdownArgumentValue
        }

        let markdownHtml = try markdownToHTML(markdown)

        let promise = Promise(LeafData?.self)
        promise.complete(.string(markdownHtml))
        return promise.future
    }

}
