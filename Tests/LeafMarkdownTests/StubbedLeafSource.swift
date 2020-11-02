import LeafKit

struct StubbedLeafSource: LeafSource {

    let templateName: String
    let templateContents: String

    func file(template: String, escape: Bool, on eventLoop: EventLoop) -> EventLoopFuture<ByteBuffer> {
        if template == templateName {
            let byteBuffer = ByteBuffer(string: templateContents)
            return eventLoop.makeSucceededFuture(byteBuffer)
        } else {
            return eventLoop.makeFailedFuture(LeafMarkdownTestError())
        }
    }
}
