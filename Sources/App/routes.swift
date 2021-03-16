import Vapor
import HTMLBuilder

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req in
        HTML {
            Head {
                Title("Hello World")
                Stylesheet(href: "styles/main.css")
                Stylesheet(href: "styles/semantic.min.css")
            }

            Body {
                Center {
                    Headline1("Noah Peeters")
                    Headline2("🌱 Vegan CS Student and iOS Developer")
                }
                .padding(top: 100, bottom: 0, left: 0, right: 0)
            }
        }
    }
}

extension HTML: ResponseEncodable {
    public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
        let res = Response(headers: htmlHeaders, body: .init(string: build()))
        return request.eventLoop.makeSucceededFuture(res)
    }
}

let htmlHeaders: HTTPHeaders = ["content-type": "text/html; charset=utf-8"]
