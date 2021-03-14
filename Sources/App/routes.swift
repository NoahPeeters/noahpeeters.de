import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req in
        return req.view.render("hello", HelloContext(name: "Peeters", mainContext: MainContext(title: "Hello World", author: "Noah Peeters", pageType: .article, created: Date(), modified: Date(), published: Date())))
    }
}

struct HelloContext: MainContextProvider, Encodable {
    let name: String
    let mainContext: MainContext
}
