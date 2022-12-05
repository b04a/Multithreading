import Foundation


//Mutex - защита от потока для работы с ним (защита объекта)

//base C
//class SaveThread {
//    private var mutex = pthread_mutex_t()
//
//    init() {
//        pthread_mutex_init(&mutex, nil)
//    }
//
//    func someMethod(competion: () -> ()) {
//        pthread_mutex_lock(&mutex)
//
//        competion()
//
//        defer { //в случае бага или кряка, гарант освободит объект
//            pthread_mutex_unlock(&mutex)
//        }
//    }
//}

//base Obj-C
class SaveThread {
    private let lockMutex = NSLock()
    
    func someMethod(competion: () -> ()) {
        lockMutex.lock()
        
        competion()
        
        defer { //в случае бага или кряка, гарант освободит объект
            lockMutex.unlock()
        }
    }
}


var array = [String]()
let saveThread = SaveThread()

saveThread.someMethod {
    print("test123")
    array.append("1 thread")
}

array.append("2 thread")

