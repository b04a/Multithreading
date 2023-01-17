import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//var array = [Int]()
//
//for i in 0...9 {
//    array.append(i)
//}
//
//print(array)
//print(array.count)
//
//
////[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
////10

//var array = [Int]()
//
//DispatchQueue.concurrentPerform(iterations: 10) { index in
//    array.append(index)
//}
//
//print(array)
//print(array.count)


class SaveArray<T> {
    private var array = [T]()
    private var queue = DispatchQueue(label: "future hendrix", attributes: .concurrent)
    
    public func append(_ value: T) {
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
    
    public var valueArray: [T] {
        var result = [T]()
        
        queue.sync {
            result = self.array
        }
        return result
    }
}

var arraySafe = SaveArray<Int>()
DispatchQueue.concurrentPerform(iterations: 10) { index in
    arraySafe.append(index)
}
print("arraySafe:", arraySafe.valueArray)
print("arraySafe:", arraySafe.valueArray.count)
