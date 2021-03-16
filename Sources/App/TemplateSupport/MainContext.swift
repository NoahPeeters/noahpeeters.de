import Foundation

struct MainContext: ViewContext {
    let websiteName: String = "Noah Peeters"
    let websiteDescription: String = "Homepage of Noah Peeters"
    let goatcounterID: String? = "noahpeeters"
    let websiteURL: URL = URL(string: "https://noahpeeters.de")!
}
