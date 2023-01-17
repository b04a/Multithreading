import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())

timer.setEventHandler {
    print("!")
}

timer.schedule(deadline: .now(), repeating: 2)
timer.activate()
