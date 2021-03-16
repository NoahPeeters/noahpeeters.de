//
//  File.swift
//  
//
//  Created by Noah Peeters on 15.03.21.
//

import Foundation

public struct XMLTag: XMLElement {
    public let name: String
    public let attributes: XMLTagAttributes
    public let css: CSSProperties
    public let body: XMLElement

    public init(name: String, attributes: XMLTagAttributes = .empty, css: CSSProperties = .empty, @XMLBuilder body: () -> XMLElement = Empty.init) {
        self.name = name
        self.attributes = attributes
        self.css = css
        self.body = body()
    }

    public func mapAttributes(mapper: (XMLTagAttributes) -> XMLTagAttributes) -> XMLElement {
        XMLTag(name: name, attributes: mapper(attributes), css: css) { body }
    }
    public func mapCSSProperties(mapper: (CSSProperties) -> CSSProperties) -> XMLElement {
        XMLTag(name: name, attributes: attributes, css: mapper(css)) { body }
    }
}

extension XMLTag {
    private func buildAttributesWithLeadingSpace() -> String {
        let buildedString = attributes
            .set(key: "style", value: css.build())
            .build()
        return buildedString.isEmpty ? "" : " " + buildedString
    }

    public func buildLines(outputFormatting: OutputFormatting) -> [String] {
        let bodyLines = outputFormatting.applyToBodyLines(body.buildLines(outputFormatting: outputFormatting))

        let encodedName = name.xmlEncoded()

        if bodyLines.isEmpty {
            return ["<\(encodedName)\(buildAttributesWithLeadingSpace())/>"]
        } else {
            return ["<\(encodedName)\(buildAttributesWithLeadingSpace())>"] + bodyLines + ["</\(encodedName)>"]
        }
    }
}
