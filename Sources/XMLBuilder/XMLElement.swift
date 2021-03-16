//
//  File.swift
//  
//
//  Created by Noah Peeters on 15.03.21.
//

import Foundation

public protocol XMLElement {
    func buildLines(outputFormatting: OutputFormatting) -> [String]
    var body: XMLElement { get }

    func mapAttributes(mapper: (XMLTagAttributes) -> XMLTagAttributes) -> XMLElement
    func mapCSSProperties(mapper: (CSSProperties) -> CSSProperties) -> XMLElement
}

extension XMLElement {
    public func build(outputFormatting: OutputFormatting = .minified) -> String {
        buildLines(outputFormatting: outputFormatting)
            .joined(separator: "\n")
    }

    public func buildLines(outputFormatting: OutputFormatting) -> [String] {
        body.buildLines(outputFormatting: outputFormatting)
    }

    public func mapAttributes(mapper: (XMLTagAttributes) -> XMLTagAttributes) -> XMLElement {
        body.mapAttributes(mapper: mapper)
    }

    public func mapCSSProperties(mapper: (CSSProperties) -> CSSProperties) -> XMLElement {
        body.mapCSSProperties(mapper: mapper)
    }
}

extension XMLElement {
    public func setAttribute(key: String, value: String) -> XMLElement {
        mapAttributes { $0.set(key: key, value: value) }
    }

    public func deleteAttribute(key: String) -> XMLElement {
        mapAttributes { $0.remove(key: key) }
    }

    public func appendAttribute(key: String, value: String, separator: String = " ") -> XMLElement {
        mapAttributes {
            $0.map(key: key) { oldValue in
                if let oldValue = oldValue {
                    return "\(oldValue)\(separator)\(value)"
                } else {
                    return value
                }
            }
        }
    }
}

extension XMLElement {
    public func setCSSProperty(_ key: String, value: String) -> XMLElement {
        mapCSSProperties { $0.set(key: key, value: value) }
    }
}
