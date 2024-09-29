import SwiftUI

@main
struct TimeTapWatch_Watch_AppApp: App {
    @State private var env = Env()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(env)
        }
    }
}
