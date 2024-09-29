import Foundation
import WatchKit

struct Lib {
    static func newTimer(seconds: Double) -> TapTimer {
        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(seconds), repeats: true, block: { _ in
            WKInterfaceDevice.current().play(.start)
        })
        
        return TapTimer(timer: timer)
    }
    
    static func doubleToString(_ d: Double) -> String {
        return String(format: "%.2f", d)
    }
    
    static func timeIntervalToString(_ ti: TimeInterval) -> String {
        return doubleToString(ti.magnitude)
    }
}
