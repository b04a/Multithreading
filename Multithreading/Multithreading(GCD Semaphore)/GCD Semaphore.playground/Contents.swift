import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "Future Hendrix", attributes: .concurrent)

let semaphore = DispatchSemaphore(value: 2)

queue.async {
    semaphore.wait()  //- 1
    sleep(2)
    print("method 1")
    semaphore.signal() //+ 1
}

queue.async {
    semaphore.wait()  //-1
    sleep(2)
    print("method 2")
    semaphore.signal()
}

queue.async {
    semaphore.wait()  //-1
    sleep(2)
    print("method 3")
    semaphore.signal()
}

//let sem = DispatchSemaphore(value: 2)
//DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
//    sem.wait(timeout: DispatchTime.distantFuture)
//    sleep(1)
//    print("block", String(id))
//    sem.signal()
//}


//class SemaphoreTest {
//    private let semaphore = DispatchSemaphore(value: 1)
//    private var array = [Int]()
//
//    private func methodWor(_ id: Int) {
//        semaphore.wait() // -1
//
//        array.append(id)
//        print("test array", array.count)
//
//        Thread.sleep(forTimeInterval: 1)
//        semaphore.signal() // +1
//    }
//
//    public func start() {
//        DispatchQueue.global().async {
//            self.methodWor(123)
//            //print(Thread.current)
//        }
//
//        DispatchQueue.global().async {
//            self.methodWor(312)
//            //print(Thread.current)
//        }
//
//        DispatchQueue.global().async {
//            self.methodWor(312)
//            //print(Thread.current)
//        }
//
//        DispatchQueue.global().async {
//            self.methodWor(312)
//            //print(Thread.current)
//        }
//    }
//}
//
//let semaphoreTest = SemaphoreTest()
//semaphoreTest.start()
