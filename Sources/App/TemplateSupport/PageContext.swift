import Foundation

enum PageType: String, Encodable {
    case article
}

struct PageContext: ViewContext {
    let title: String
    let author: String
    let pageType: PageType
    let created: Date
    let modified: Date
    let published: Date
}
