import Vapor
import vapor_markdown

let droplet = Droplet(providers: [vapor_markdown.Provider])

droplet.get { req in
    return try droplet.view.make("index.md")
}

droplet.serve()
