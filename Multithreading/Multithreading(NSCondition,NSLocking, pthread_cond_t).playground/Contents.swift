import Foundation

var str = "NSCondition()"


var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()


//Thread1
class ContionMutexPrinter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printerMethod()
    }
    
    private func printerMethod() {
        pthread_mutex_lock(&mutex)
        print("printerMethod")
        while (!available) {
            pthread_cond_wait(&condition, &mutex)
        }
        available = false
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
        print("printerMethod exit")
    }
}

//Thread2
class ContionMutexWriter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writerMethod()
    }
    
    private func writerMethod() {
        pthread_mutex_lock(&mutex)
        print("writerMethod")
        available = true
        //etc method
        pthread_cond_signal(&condition)
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
        print("writerMethod exit")
    }
}

let contionMutexWriter = ContionMutexWriter()
let contionMutexPrinter = ContionMutexPrinter()

//contionMutexPrinter.start()
//contionMutexWriter.start()

let cond = NSCondition()
var availabless = false


class WriterThread: Thread {
    override func main() {
        cond.lock()
        print("WriterThread enter")
        availabless = true
        cond.signal()
        cond.unlock()
        print("WriterThread exit")
    }
}

class PrinterThred: Thread {
    override func main() {
        cond.lock()
        print("PrinterThred enter")
        while (!availabless) {
            cond.wait()
        }
        availabless = false
        cond.unlock()
        print("PrinterThred exit")
    }
}

var writerThread = WriterThread()
var printerThred = PrinterThred()

printerThred.start()
writerThread.start()























