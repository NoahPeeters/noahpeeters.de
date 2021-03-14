import Vapor
import Leaf
import LeafKit

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
    try configureLeaf(app)

    configureCustomTags(app)
}

private func configureLeaf(_ app: Application) throws {
    let rootDirectory =  app.directory.viewsDirectory

    let sources = LeafSources()
    try sources.register(using: NIOLeafFiles(fileio: app.fileio,
                                             limits: .default,
                                             sandboxDirectory: rootDirectory,
                                             viewDirectory: rootDirectory,
                                             defaultExtension: "html"))

    app.leaf.sources = sources
    app.views.use(.leaf)
}

private func configureCustomTags(_ app: Application) {
    app.leaf.tags["canonicalURL"] = CanonicalURL()
    app.leaf.tags["now"] = NowTag()
}
