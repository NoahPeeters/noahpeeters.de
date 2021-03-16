//
//  File.swift
//  
//
//  Created by Noah Peeters on 12.02.21.
//

import Foundation

//public protocol XMLTagBuilder: XMLElement {
//    associatedtype XMLType: XMLTagType
//    var type: XMLType { get }
//    var attributes: XMLTagAttributes { get }
//}
//
//extension XMLTagBuilder {
//    public func buildLines(outputFormatting: OutputFormatting) -> [String] {
//        (self>{Empty()}).buildLines(outputFormatting: outputFormatting)
//    }
//}
//
//public protocol XMLTagType: XMLTagBuilder where XMLType == Self {
//    var name: String { get }
//}
//
//extension XMLTagType {
//    public var type: XMLType { self }
//    public var attributes: XMLTagAttributes { .empty }
//}
//
//public struct XMLTagAttributeBuilder<XMLType: XMLTagType>: XMLTagBuilder {
//    public let type: XMLType
//    public let attributes: XMLTagAttributes
//
//    init(type: XMLType, attributes: XMLTagAttributes) {
//        self.type = type
//        self.attributes = attributes
//    }
//}
//
//extension XMLTagBuilder {
//    func mapAttributes(mapper: (XMLTagAttributes) -> XMLTagAttributes) -> XMLTagAttributeBuilder<XMLType> {
//        XMLTagAttributeBuilder(type: type, attributes: mapper(attributes))
//    }
//
//    public func setAttribute(key: String, value: String) -> XMLTagAttributeBuilder<XMLType> {
//        mapAttributes { $0.set(key: key, value: value) }
//    }
//
//    public func deleteAttribute(key: String) -> XMLTagAttributeBuilder<XMLType> {
//        mapAttributes { $0.remove(key: key) }
//    }
//
//    public func appendAttribute(key: String, value: String, separator: String = " ") -> XMLTagAttributeBuilder<XMLType> {
//        mapAttributes {
//            $0.map(key: key) { oldValue in
//                if let oldValue = oldValue {
//                    return "\(oldValue)\(separator)\(value)"
//                } else {
//                    return value
//                }
//            }
//        }
//    }
//}
//
//public func ><TagBuilder: XMLTagBuilder>(tagBuilder: TagBuilder, @XMLBuilder body: () -> XMLElement) -> XMLTag {
//    XMLTag(name: tagBuilder.type.name,
//           attributes: tagBuilder.attributes,
//           body: body())
//}
