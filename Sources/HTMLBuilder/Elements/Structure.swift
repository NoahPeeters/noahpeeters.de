//
//  File.swift
//  
//
//  Created by Noah Peeters on 15.03.21.
//

import XMLBuilder

public struct HTML: XMLElement {
    let content: XMLElement

    public init(@XMLBuilder content: () -> XMLElement) {
        self.content = content()
    }

    public var body: XMLElement {
        XMLTag(name: "html") { content }
    }
}

public struct Head: XMLElement {
    let content: XMLElement

    public init(@XMLBuilder content: () -> XMLElement) {
        self.content = content()
    }

    public var body: XMLElement {
        XMLTag(name: "head") { content }
    }
}

public struct Body: XMLElement {
    let content: XMLElement

    public init(@XMLBuilder content: () -> XMLElement) {
        self.content = content()
    }

    public var body: XMLElement {
        XMLTag(name: "body") { content }
    }
}

public struct Center: XMLElement {
    let content: XMLElement

    public init(@XMLBuilder content: () -> XMLElement) {
        self.content = content()
    }

    public var body: XMLElement {
        XMLTag(name: "div") { content }
            .appendAttribute(key: "class", value: "ui center aligned container")
    }
}

extension XMLElement {
    public func padding(top: Double, bottom: Double, left: Double, right: Double) -> XMLElement {
        setCSSProperty("padding", value: "\(top)px \(right)px \(bottom)px \(left)px")
    }
}
