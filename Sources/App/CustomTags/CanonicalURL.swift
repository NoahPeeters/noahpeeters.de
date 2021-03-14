import Foundation
import Leaf
import Vapor

struct CanonicalURL: LeafTag {
    static let baseURL = URL(string: "https://noahpeeters.de")!

    func render(_ ctx: LeafContext) throws -> LeafData {
        try ctx.requireParameterCount(0)
        return LeafData(stringLiteral: url(for: ctx.request).standardized.absoluteString)
    }

    private func url(for request: Request?) -> URL {
        if let url = request?.url {
            return CanonicalURL.baseURL.appendingPathComponent(url.path)
        } else {
            return CanonicalURL.baseURL
        }
    }
}
