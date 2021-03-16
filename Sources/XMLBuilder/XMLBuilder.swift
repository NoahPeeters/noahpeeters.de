import Foundation

@_functionBuilder
public struct XMLBuilder {
    public static func buildBlock() -> XMLElement {
        Empty()
    }

    public static func buildBlock(_ elements: XMLElement...) -> XMLElement {
        Group(elements: elements)
    }

    public static func buildIf(_ element: XMLElement?) -> XMLElement {
        element ?? Empty()
    }

    public static func buildEither(first: XMLElement) -> XMLElement {
        first
    }

    public static func buildEither(second: XMLElement) -> XMLElement {
        second
    }

    public static func buildOptional<E: XMLElement>(_ component: E?) -> XMLElement {
        component ?? Empty()
    }
}
