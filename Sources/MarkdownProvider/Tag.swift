import Leaf
import SwiftMarkdown
import Async

public final class Markdown: LeafTag {

    public let name = "markdown"

    public func render(parsed: ParsedTag, context: LeafContext, renderer: LeafRenderer) throws -> Future<LeafData?> {
        return Future(nil)
    }





//    public enum Error: Swift.Error {
//        case invalidArgument(Argument?)
//    }
//
//    public init() { }
//
//    public let name = "markdown"
//
//    public func shouldRender(stem: Stem, context: Context, tagTemplate: TagTemplate, arguments: [Argument], value: Node?) -> Bool{
//        return true
//    }
//
//    public func run(tagTemplate: TagTemplate, arguments: ArgumentList) throws -> Node? {
//        var markdown = ""
//
//        if let markdownArgument = arguments.first {
//            guard let markdownArgumentValue = markdownArgument.string else {
//                throw Error.invalidArgument(arguments.list.first)
//            }
//            markdown = markdownArgumentValue
//        }
//
//        let markdownHtml = try markdownToHTML(markdown)
//        let unescaped = markdownHtml.bytes
//        return .bytes(unescaped)
//    }

}
