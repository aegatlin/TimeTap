import SwiftUI

struct ContentView: View {
    @Environment(Env.self) private var env
    @State private var showNewTimerView: Bool = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                if (env.timers.isEmpty) {
                    Text("No active timers")
                } else {
                    List {
                        ForEach(env.timers) {t in
                            NavigationLink(Lib.timeIntervalToString(t.timer.timeInterval), value: t)
                                .padding(.horizontal)
                        }
                        .onDelete(perform: { indexSet in
                            env.deleteByIndexSet(indexSet)
                        })
                    }
                    .navigationDestination(for: TapTimer.self)  { t in
                        TimerView(timer: t, onDelete: {
                            navigationPath.removeLast()
                            env.deleteById(t.id)
                        }, onPause: {
                            print("to be implemented :D")
                        }, onAdd: {
                            showNewTimerView = true
                        })
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showNewTimerView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showNewTimerView,onDismiss: {
            showNewTimerView = false
        }, content: {
            NewTimerView(onNewTimer: {
                showNewTimerView = false
            })
        })
    }
}

#Preview("No timers") {
    ContentView()
        .environment(Env())
}

#Preview("One timer") {
    ContentView()
        .environment(Env.testEnvWithOneTimer())
}
