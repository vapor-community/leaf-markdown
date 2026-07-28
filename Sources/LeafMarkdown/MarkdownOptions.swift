import cmark_gfm

/// Options controlling how markdown is parsed and rendered to HTML.
///
/// These map directly onto the underlying cmark-gfm options.
public struct MarkdownOptions: OptionSet, Sendable {
    public var rawValue: Int32

    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    // MARK: - Rendering

    /// Render raw HTML and unsafe links (`javascript:`, `vbscript:`, `file:` and most
    /// `data:` URLs) instead of stripping them.
    ///
    /// By default cmark replaces raw HTML with an HTML comment and unsafe links with an
    /// empty string. Only enable this for markdown you trust.
    public static let unsafe = MarkdownOptions(rawValue: CMARK_OPT_UNSAFE)

    /// Include a `data-sourcepos` attribute on all block elements.
    public static let sourcePos = MarkdownOptions(rawValue: CMARK_OPT_SOURCEPOS)

    /// Render soft break elements as hard line breaks.
    public static let hardBreaks = MarkdownOptions(rawValue: CMARK_OPT_HARDBREAKS)

    /// Render soft break elements as spaces.
    public static let noBreaks = MarkdownOptions(rawValue: CMARK_OPT_NOBREAKS)

    /// Use GitHub-style `<pre lang="x">` tags for code blocks instead of
    /// `<pre><code class="language-x">`.
    public static let githubPreLang = MarkdownOptions(rawValue: CMARK_OPT_GITHUB_PRE_LANG)

    /// Use `style` attributes to align table cells instead of `align` attributes.
    public static let tablePreferStyleAttributes = MarkdownOptions(rawValue: CMARK_OPT_TABLE_PREFER_STYLE_ATTRIBUTES)

    // MARK: - Parsing

    /// Validate UTF-8 in the input before parsing, replacing illegal sequences with U+FFFD.
    public static let validateUTF8 = MarkdownOptions(rawValue: CMARK_OPT_VALIDATE_UTF8)

    /// Convert straight quotes to curly, `---` to em dashes and `--` to en dashes.
    public static let smart = MarkdownOptions(rawValue: CMARK_OPT_SMART)

    /// Be liberal in interpreting inline HTML tags.
    public static let liberalHTMLTag = MarkdownOptions(rawValue: CMARK_OPT_LIBERAL_HTML_TAG)

    /// Parse footnotes.
    public static let footnotes = MarkdownOptions(rawValue: CMARK_OPT_FOOTNOTES)

    /// Only parse strikethroughs if surrounded by exactly two tildes.
    public static let strikethroughDoubleTilde = MarkdownOptions(rawValue: CMARK_OPT_STRIKETHROUGH_DOUBLE_TILDE)

    /// Include the full info string of a code block in the `data-meta` attribute.
    public static let fullInfoString = MarkdownOptions(rawValue: CMARK_OPT_FULL_INFO_STRING)
}
