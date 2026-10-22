public import LeafKit
import Foundation
import cmark_gfm
import cmark_gfm_extensions

public struct MarkdownTag: UnsafeUnescapedLeafTag {
    public enum Error: Swift.Error {
        case invalidArgument(LeafData?)
        case parsingFailed
        case renderingFailed
    }

    /// The GitHub Flavored Markdown extensions attached to the parser.
    private static let extensionNames = ["table", "strikethrough", "tasklist", "autolink", "tagfilter"]

    private let options: MarkdownOptions

    public init(options: MarkdownOptions = []) {
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

        return .string(try Self.markdownToHTML(markdown, options: options))
    }

    public static func markdownToHTML(_ markdown: String, options: MarkdownOptions) throws -> String {
        cmark_gfm_core_extensions_ensure_registered()

        guard let parser = cmark_parser_new(options.rawValue) else {
            throw Error.parsingFailed
        }
        defer { cmark_parser_free(parser) }

        for name in Self.extensionNames {
            if let syntaxExtension = cmark_find_syntax_extension(name) {
                cmark_parser_attach_syntax_extension(parser, syntaxExtension)
            }
        }

        cmark_parser_feed(parser, markdown, markdown.utf8.count)

        guard let document = cmark_parser_finish(parser) else {
            throw Error.parsingFailed
        }
        defer { cmark_node_free(document) }

        // The extension list is owned by the parser, so this must happen before it is freed.
        guard let html = cmark_render_html(document, options.rawValue, cmark_parser_get_syntax_extensions(parser)) else {
            throw Error.renderingFailed
        }
        defer { free(html) }

        return String(cString: html)
    }
}
