import Vapor
import Foundation
import VaporMarkdown

let drop = Droplet()

if let leaf = drop.view as? LeafRenderer {
    leaf.stem.register(Markdown())
}

drop.get { req in
    return try drop.view.make("index.leaf", ["greeting": .string("World")])
}

drop.run()
