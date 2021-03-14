import Foundation

enum PageType: String, Encodable {
    case article
}

struct MainContext: Encodable {
    let title: String
    let author: String
    let pageType: PageType
    let created: Date
    let modified: Date
    let published: Date

    let websiteName = "Noah Peeters"
    let websiteDescription = "Homepage of Noah Peeters"
    let goatcounterID = "noahpeeters"
    let websiteURL = URL(string: "https://noahpeeters.de")!
}

protocol MainContextProvider {
    var mainContext: MainContext { get }
}
