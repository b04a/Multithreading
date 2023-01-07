import Foundation
import PlaygroundSupport

print("--- Имитация race condition ---")
let mySerialQueue = DispatchQueue(label: "com.bestkora.mySerial")

var value = "😇"
func changeValue(variant: Int) {
    sleep(1)
    value = value + "🐔"
    print ("\(value) - \(variant)")
}


mySerialQueue.sync { //reswap sync on async
    changeValue(variant: 1)
}
value


value = "🦊"
mySerialQueue.sync {
    changeValue(variant:2)
}
value
sleep(3)
