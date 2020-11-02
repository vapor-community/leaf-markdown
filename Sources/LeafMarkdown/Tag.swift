import LeafKit
import SwiftMarkdown

public struct Markdown: LeafFunction, StringReturn, Invariant {
    
    private let options: MarkdownOptions?
    
    public init(options: MarkdownOptions? = nil) {
        self.options = options
    }

    public static let callSignature: [LeafCallParameter] = [.string]

    public func evaluate(_ params: LeafCallValues) -> LeafData {
        var markdown = ""

        if params.count > 0 {
            guard let markdownArgumentValue = params[0].string else {
                return .error("Failed to get markdown from parameter")
            }
            markdown = markdownArgumentValue
        }

        let markdownHTML: String
        do {
            if let options = options {
                markdownHTML = try markdownToHTML(markdown, options: options)
            } else {
                markdownHTML = try markdownToHTML(markdown)
            }
        } catch {
            return .error("Failed to convert markdown string to HTML - \(error)")
        }

        return .string(markdownHTML)
    }
}
