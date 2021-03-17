import Vapor
import API

func routes(_ app: Application) throws {
    app.handleAPIRequest(request: ServerDateRequest.self) {
        ServerDateRequest.Response(date: Date())
    }
}

private let jsonEncoder = JSONEncoder()

extension Application {
    func handleAPIRequest<Request: APIRequest>(request: Request.Type, _ handler: @escaping () -> Request.Response) {
        self.get(Request.path.pathComponents) { req in
            try String(data: jsonEncoder.encode(handler()), encoding: .utf8)!
        }
    }
}
