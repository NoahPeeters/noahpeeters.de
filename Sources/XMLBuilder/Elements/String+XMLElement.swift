//
//  File.swift
//  
//
//  Created by Noah Peeters on 15.03.21.
//

import Foundation

extension String: XMLElement {
    public func buildLines(outputFormatting: OutputFormatting) -> [String] {
        [xmlEncoded()]
    }

    public var body: XMLElement {
        Empty()
    }
}
