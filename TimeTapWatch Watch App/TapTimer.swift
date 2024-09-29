import Foundation
import WatchKit

struct TapTimer: Hashable, Identifiable {
    let id: UUID
    let timer: Timer
    
    init(timer: Timer) {
        self.id = UUID()
        self.timer = timer
    }
    
    func readProgress() -> Double {
        let a = Date().distance(to: timer.fireDate)
        let b = timer.timeInterval
        let c = a.magnitude / b.magnitude
        return c
    }
    
    func displayInterval() -> String {
        return String(format: "%.2f", timer.timeInterval)
    }
}
