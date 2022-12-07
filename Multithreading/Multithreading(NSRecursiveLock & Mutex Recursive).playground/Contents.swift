import Foundation


let recursiveLock = NSRecursiveLock()

class RecursiveThread: Thread {
    
    override func main() {
        recursiveLock.lock()
        print("lock")
        callMe()
        
        defer {
            recursiveLock.unlock()
        }
        print("unlock")
    }
    
    func callMe() {
        recursiveLock.lock()
        print("lock")
        defer {
            recursiveLock.unlock()
        }
        print("exit callme")
    }
}

let thread = RecursiveThread()
thread.start()
