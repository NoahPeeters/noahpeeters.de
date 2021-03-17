import Foundation

public struct ServerDateRequest: APIRequest {
    public static let path = "server/date"

    public init() {}

    public struct Response: APIResponse {
        public let date: Date

        public init(date: Date) {
            self.date = date
        }
    }
}
