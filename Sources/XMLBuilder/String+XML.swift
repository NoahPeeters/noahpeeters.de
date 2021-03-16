//
//  File.swift
//  
//
//  Created by Noah Peeters on 15.03.21.
//

import Foundation

extension String {
    func xmlEncoded() -> String {
        self.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "'", with: "&apos;")
            .replacingOccurrences(of: "\"", with: "&quot;")
    }
}
