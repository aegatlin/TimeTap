import Foundation
import SwiftUI

struct TimerView: View {
    var timer: TapTimer
    var onDelete: () -> Void
    var onPause: () -> Void
    var onAdd: () -> Void
    
    @State private var progress: Double = 0.0
    @State private var progressTimer: Timer?
    
    var body: some View {
        VStack {
            ZStack {
                Text(Lib.doubleToString(progress))
                    .font(.title)
                ProgressView(value: progress)
                    .progressViewStyle(.circular)
                    .padding(8)
                    .onAppear {
                        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: {_ in
                            progress = timer.readProgress()
                        })
                    }
                    .onDisappear {
                        progressTimer?.invalidate()
                        progressTimer = nil
                    }
                    .scaleEffect(3)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("Add", systemImage: "plus") {
                    onAdd()
                }
            })
            ToolbarItem(placement: .bottomBar, content: {
                Button("Delete", systemImage: "multiply") {
                    onDelete()
                }
            })
            ToolbarItem(placement: .bottomBar, content: {
                Button("Pause", systemImage: "pause") {
                    onPause()
                }
            })
        }
    }
    
    func formatDateIntervalText(number: DateInterval) -> String {
        let f = DateIntervalFormatter()
        f.timeStyle = .short
        f.dateStyle = .none
        
        return f.string(from: number) ?? "0"
    }
}


#Preview {
    TimerView(
        timer: Lib.newTimer(seconds: 1),
        onDelete: {},
        onPause: {},
        onAdd: {}
    )
}
