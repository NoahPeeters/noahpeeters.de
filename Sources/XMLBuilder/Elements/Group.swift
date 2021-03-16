//
//  File.swift
//  
//
//  Created by Noah Peeters on 15.03.21.
//

import Foundation

public struct Group: XMLElement {
    private let elements: [XMLElement]

    public init(elements: [XMLElement]) {
        self.elements = elements
    }

    public func buildLines(outputFormatting: OutputFormatting) -> [String] {
        elements.flatMap { $0.buildLines(outputFormatting: outputFormatting) }
    }

    public func mapAttributes(mapper: (XMLTagAttributes) -> XMLTagAttributes) -> XMLElement {
        Group(elements: elements.map { $0.mapAttributes(mapper: mapper) })
    }

    public func mapCSSProperties(mapper: (CSSProperties) -> CSSProperties) -> XMLElement {
        Group(elements: elements.map { $0.mapCSSProperties(mapper: mapper) })
    }

    public var body: XMLElement {
        fatalError("Not implemented")
    }
}
