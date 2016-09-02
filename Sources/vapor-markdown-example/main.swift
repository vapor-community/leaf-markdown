import Vapor
import Foundation
import vapor_markdown

let droplet = Droplet(providers: [LeafMarkdownProvider.self])

droplet.get { req in
    return try droplet.view.make("index.leaf", ["greeting": .string("World")])
}

droplet.serve()
