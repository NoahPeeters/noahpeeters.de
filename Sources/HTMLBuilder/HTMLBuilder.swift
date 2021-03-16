//
//  File.swift
//  
//
//  Created by Noah Peeters on 12.02.21.
//

import XMLBuilder



//public let html = HTML()
//public struct HTML: XMLTagType {
//    public let name = "html"
//    public init() {}
//}
//
//public let head = HEAD()
//public struct HEAD: XMLTagType {
//    public let name = "head"
//    public init() {}
//}
//
//public let body = BODY()
//public struct BODY: XMLTagType {
//    public let name = "body"
//    public init() {}
//}
//
//public let title = Title()
//public struct Title: XMLTagType {
//    public let name = "title"
//    public init() {}
//}
//
//
//public protocol HTMLBodyTag: XMLTagType {}
//
//public let div = Div()
//public struct Div: HTMLBodyTag {
//    public let name = "div"
//    public init() {}
//}
//
//public extension XMLTagBuilder where XMLType: HTMLBodyTag {
//    func id(_ id: String) -> XMLTagAttributeBuilder<XMLType> {
//        setAttribute(key: "id", value: id)
//    }
//    func `class`(_ classNames: String...) -> XMLTagAttributeBuilder<XMLType> {
//        appendAttribute(key: "class", value: classNames.joined(separator: " "))
//    }
//}
