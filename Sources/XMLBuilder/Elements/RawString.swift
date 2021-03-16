//
//  File.swift
//  
//
//  Created by Noah Peeters on 15.03.21.
//

import Foundation

public struct RawString: XMLElement {
    private let string: String

    public init(_ string: String) {
        self.string = string
    }

    public func buildLines(outputFormatting: OutputFormatting) -> [String] {
        [string]
    }

    public var body: XMLElement {
        Empty()
    }
}
