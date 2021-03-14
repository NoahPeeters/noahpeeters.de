import Foundation
import Leaf
import Vapor

enum NowTagError: Error {
    case invalidDateString
}

final class NowTag: LeafTag {
    init() { }

    func render(_ ctx: LeafContext) throws -> LeafData {
        let formatter = DateFormatter()
        formatter.dateFormat = ctx.parameters.first?.string ?? "yyyy-MM-dd HH:mm:ss"
        return LeafData(stringLiteral: formatter.string(from: Date()))
    }
}
