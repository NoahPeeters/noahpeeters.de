import Foundation
import TokamakDOM
import Helper
import JavaScriptKit
import API

public struct FrontendRoot: App {
    public init() {}

    public var body: some Scene {
        WindowGroup("Tokamak App") {
            ContentView()
                .onAppear {
                    let document = JSObject.global.document

                    _ = document.head.insertAdjacentHTML("beforeend",#"""
                    <link
                      rel="stylesheet"
                      href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css">
                    """#)
                }
        }
    }
}

struct ContentView: View {
    private let location = JSObject.global.location.object!

    @State var text = ""

    var body: some View {
        VStack {
            Text(text).font(.headline)
            TextField("Enter text", text: $text)
            Counter(count: 2, limit: 10)

            Button("Modify Location") { location.pathname = "Test" }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            let apiClient = APIClient()

            apiClient.fetch(ServerDateRequest())
                .startWithOutput { response in
                    let dateFormatter = DateFormatter()

                    text = dateFormatter.string(from: response.date)
                }
        }
    }
}


struct Counter: View {
    @State var count: Int
    let limit: Int

    var body: some View {
        if count < limit {
            VStack {
                Button("Increment") { count += 1 }
                Text("\(count)")
            }
            .onAppear { print("Counter.VStack onAppear") }
            .onDisappear { print("Counter.VStack onDisappear") }
        } else {
            VStack { Text("Limit exceeded") }
        }
    }
}
