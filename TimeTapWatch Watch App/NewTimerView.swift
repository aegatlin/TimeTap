import Foundation
import SwiftUI

struct NewTimerView: View {
    var onNewTimer: () -> Void
    @Environment(Env.self) private var env
    @State private var selectedInterval: Double = 1.0
    
    var body: some View {
        VStack {
            Picker("Select Interval", selection: $selectedInterval) {
                ForEach(1..<61) { second in
                    Text("\(second) sec").tag(Double(second))
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
            
            Spacer()
            
            Button(action: {
                let newTimer = Lib.newTimer(seconds: selectedInterval)
                env.timers.append(newTimer)
                onNewTimer()
            }, label: {
                Text("Start")
            })
        }
    }
}

#Preview {
    NewTimerView(onNewTimer: {
        print("new timer created")
    })
        .environment(Env())
}
