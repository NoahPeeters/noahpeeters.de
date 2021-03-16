//
//  File.swift
//  
//
//  Created by Noah Peeters on 15.03.21.
//

import Foundation

public struct Empty: XMLElement {
    public func buildLines(outputFormatting: OutputFormatting) -> [String] {
        []
    }

    public func mapAttributes(mapper: (XMLTagAttributes) -> XMLTagAttributes) -> XMLElement {
        self
    }

    public init() {}

    public var body: XMLElement {
        fatalError("Not Implemented")
    }
}

extension Never: XMLElement {
    public var body: XMLElement {
        Empty()
    }
}
