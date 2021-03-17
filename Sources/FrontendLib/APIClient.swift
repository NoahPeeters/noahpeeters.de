import Foundation
import JavaScriptKit
import OpenCombine
import API

public struct APIClient {
    private let _jsFetch = JSObject.global.fetch.function!
    private let decoder = JSONDecoder()

    private let baseURL = URL(string: "http://127.0.0.1:8081/")!

    func fetch<Request: APIRequest>(_ request: Request) -> AnyPublisher<Request.Response, Error> {
        var urlComponents = URLComponents()
        urlComponents.path = Request.path

        return Just(urlComponents.url(relativeTo: baseURL))
            .tryMap { (url: URL?) -> URL in
                guard let url = url else {
                    throw APIClientError.invalidURL
                }
                return url
            }
            .flatMap { url in
                JSPromise<JSObject, JSError>(_jsFetch(url.absoluteString).object!)!
                    .publisher
                    .mapError { $0 as Error }
            }
            .flatMap {
                JSPromise<JSValue, JSError>($0.text!().object!)!
                    .publisher
                    .mapError { $0 as Error }
            }
            .map { Data($0.string!.utf8) }
            .tryMap { data in
                try decoder.decode(Request.Response.self, from: data)
            }
            .eraseToAnyPublisher()
    }
}

public enum APIClientError: Error {
    case invalidURL
}
