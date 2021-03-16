//
//  File.swift
//  
//
//  Created by Noah Peeters on 16.03.21.
//

import XMLBuilder

public protocol Headline: XMLElement {
    init(@XMLBuilder content: () -> XMLElement)
}

extension Headline {
    public init(_ content: XMLElement) {
        self.init { content }
    }
}

public struct Headline1: Headline {
    let content: XMLElement

    public init(@XMLBuilder content: () -> XMLElement) {
        self.content = content()
    }

    public var body: XMLElement {
        XMLTag(name: "h1") { content }
    }
}

public struct Headline2: Headline {
    let content: XMLElement

    public init(@XMLBuilder content: () -> XMLElement) {
        self.content = content()
    }

    public var body: XMLElement {
        XMLTag(name: "h2") { content }
    }
}
