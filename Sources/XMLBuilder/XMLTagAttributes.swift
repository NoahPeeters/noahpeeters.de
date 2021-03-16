//
//  File.swift
//  
//
//  Created by Noah Peeters on 12.02.21.
//

import Foundation

protocol Attributes {
    var attributes: [String: String] { get }

    init(attributes: [String: String])

    func build() -> String
}

extension Attributes {
    public func map(key: String, valueMapper: (String?) -> String?) -> Self {
        var newAttributes = attributes
        if let newValue = valueMapper(attributes[key]) {
            newAttributes[key] = newValue
            return Self.init(attributes: newAttributes)
        } else {
            newAttributes.removeValue(forKey: key)
            return Self.init(attributes: newAttributes)
        }
    }

    public func set(key: String, value: String) -> Self {
        map(key: key) { _ in value }
    }

    public func remove(key: String) -> Self {
        map(key: key) { _ in nil }
    }
}

public struct XMLTagAttributes: Attributes {
    public let attributes: [String: String]

    public init(attributes: [String: String]) {
        self.attributes = attributes
    }

    public static var empty: XMLTagAttributes {
        Self.init(attributes: [:])
    }

    public func build() -> String {
        attributes.map { "\($0.key.xmlEncoded())=\"\($0.value.xmlEncoded())\"" }.joined(separator: " ")
    }
}

public struct CSSProperties: Attributes {
    public let attributes: [String: String]

    public init(attributes: [String: String]) {
        self.attributes = attributes
    }

    public static var empty: CSSProperties {
        Self.init(attributes: [:])
    }

    public func build() -> String {
        attributes.map { "\($0.key):\($0.value)" }.joined(separator: ";")
    }
}


