//
//  File.swift
//  
//
//  Created by Noah Peeters on 16.03.21.
//

import XMLBuilder

public struct Title: XMLElement {
    let title: String

    public init(_ title: String) {
        self.title = title
    }

    public var body: XMLElement {
        XMLTag(name: "title") { title }
    }
}


public struct Stylesheet: XMLElement {
    let href: String

    public init(href: String) {
        self.href = href
    }

    public var body: XMLElement {
        XMLTag(name: "link")
            .setAttribute(key: "href", value: href)
            .setAttribute(key: "rel", value: "stylesheet")
    }
}
