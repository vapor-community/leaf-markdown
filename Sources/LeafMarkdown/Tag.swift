public import LeafKit
public import Markdown

public struct Markdown: UnsafeUnescapedLeafTag {
    public enum Error: Swift.Error {
        case invalidArgument(LeafData?)
    }

    private let parseOptions: ParseOptions
    private let formatOptions: HTMLFormatterOptions

    public init(parseOptions: ParseOptions = [], formatOptions: HTMLFormatterOptions = []) {
        self.parseOptions = parseOptions
        self.formatOptions = formatOptions
    }

    public func render(_ ctx: LeafContext) throws -> LeafData {
        var markdown = ""
        
        if let markdownArgument = ctx.parameters.first, !markdownArgument.isNil {
            guard let markdownArgumentValue = markdownArgument.string else {
                throw Error.invalidArgument(ctx.parameters.first)
            }
            markdown = markdownArgumentValue
        }

        let document = Document(parsing: markdown, options: parseOptions)
        let markdownHTML = HTMLFormatter.format(document, options: formatOptions)

        return .string(markdownHTML)
    }
}
