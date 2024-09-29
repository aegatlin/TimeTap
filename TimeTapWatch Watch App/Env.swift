import Foundation
import WatchKit

@Observable
class Env {
    var timers: [TapTimer] = []
    
    func deleteByIndexSet(_ iSet: IndexSet) {
        if iSet.count == 1, let i = iSet.first {
            deleteByIndex(i)
        }
    }

    func deleteById(_ id: UUID) {
        if let timer = self.timers.first(where: {t in t.id == id}) {
            if let i = self.timers.firstIndex(of: timer) {
                deleteByIndex(i)
            }
        }
    }

    private func deleteByIndex(_ i: Int) {
        let timer = self.timers.remove(at: i)
        timer.timer.invalidate()
    }
}

extension Env {
    static func testEnvWithOneTimer() -> Env {
        let env = Env()
        env.timers = [
            Lib.newTimer(seconds: 1.0)
        ]
        
        return env
    }
}
