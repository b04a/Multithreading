import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//let operation1 = {
//    print("start")
//    print(Thread.current)
//    print("finish")
//}
//
//let queue = OperationQueue()
//
//queue.addOperation(operation1)

//print(Thread.current)
//
//var result: String?
//let concatOparation = BlockOperation {
//    result = "+future hendix" + " " + "dev"
//    print(Thread.current)
//}
//
////concatOparation.start()
//
//let queue = OperationQueue()
//queue.addOperation(concatOparation)
//
//print(Thread.current)
//
//let queue1 = OperationQueue()
//queue1.addOperation {
//    print("test")
//    print(Thread.current)
//}

//print(Thread.current)
//class MyThread: Thread {
//    override func main() {
//        print("test main thread")
//        print(Thread.current)
//    }
//}
//
//let myThread = MyThread()
//myThread.start()

print(Thread.current)
class OperationA: Operation {
    override func main() {
        print("Test operatios A")
        print(Thread.current)
    }
}

let operationA = OperationA()
operationA.start()

let queue = OperationQueue()
queue.addOperation(operationA)
