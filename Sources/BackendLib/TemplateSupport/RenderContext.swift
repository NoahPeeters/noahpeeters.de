//
//  RenderContext.swift
//  
//
//  Created by Noah Peeters on 15.03.21.
//

import Foundation

struct RenderContext: Encodable {
    let contexts: [String: ViewContext]

    struct StringCodingKey: RawRepresentable, CodingKey {
        let rawValue: String
        let intValue: Int? = nil

        var stringValue: String {
            rawValue
        }

        init?(rawValue: String) {
            self.rawValue = rawValue
        }

        init(_ rawValue: String) {
            self.rawValue = rawValue
        }

        init?(stringValue: String) {
            self.init(rawValue: stringValue)
        }

        init?(intValue: Int) { nil }
    }

    func encode(to encoder: Encoder) throws {
        var keyedContainer = encoder.container(keyedBy: StringCodingKey.self)

        for (rawKey, context) in contexts {
            try context.addTo(keyedContainer: &keyedContainer, key: StringCodingKey(rawKey))
        }
    }
}

protocol ViewContext: Encodable {}

extension ViewContext {
    fileprivate func addTo<Key>(keyedContainer: inout KeyedEncodingContainer<Key>, key: Key) throws {
        try keyedContainer.encode(self, forKey: key)
    }
}
