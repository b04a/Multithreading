import Foundation


var str = "Lock"

class ReadWriteLock {
    private var lock = pthread_rwlock_t()
    private var attribute = pthread_rwlockattr_r()
    
    private var globalProperty: Int = 0
    
    init() {
        pthread_rwlock_init(&lock, &attribute)
    }
    
    var workProperty: Int {
        get {
            pthread_rwlock_wrlock(&lock)
            let temp = globalProperty
            pthread_rwlock_unlock(&lock)
            return temp
        }
        set {
            pthread_rwlock_wrlock(&lock)
            globalProperty = newValue
            pthread_rwlock_unlock(&lock)
        }
    }
}

//iOS 10!
//class SpinLock {
//    private var lock = OS_SPINLOCK_INIT
//
//    func some() {
//        OSSpinLockLock(&lock)
//        //something
//        OSSpinLockUnlock(&lock)
//    }
//}

//iOS 10+
class UnfairLock {
    private var lock = os_unfair_lock_s()
    
    var array = [Int]()
    
    func some() {
        os_unfair_lock_lock(&lock)
        array.append(1)
        os_unfair_lock_unlock(&lock)
    }
}

class SynchronizedObjc {
    private var lock = NSObject()
   
    var array = [Int]()
    
    func some() {
        objs_sync_enter(lock)
        array.append(1)
        objs_sync_exit(lock)
    }
}
