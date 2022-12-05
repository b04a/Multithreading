import  Foundation


//Unix - POSIX
var thread = pthread_t(bitPattern: 0) //создаем поток
 
var attribut = pthread_attr_t()


pthread_attr_init(&attribut)
pthread_create(&thread, &attribut, { (pointer) -> UnsafeMutableRawPointer? in
    print("test")
    return nil
}, nil)


//2 Thread

var nstread = Thread {
    print("test1")
}

nstread.start()
//nstread.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
nstread.cancel()
