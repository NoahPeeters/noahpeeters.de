import Foundation

public enum OutputFormatting {
    case pretty(indent: Int)
    case minified
}

extension OutputFormatting {
    func applyToBodyLines(_ bodyLines: [String]) -> [String] {
        switch self {
        case .minified:
            return bodyLines
        case let .pretty(indent):
            return bodyLines.map { String(repeating: " ", count: indent) + $0 }
        }
    }
}

