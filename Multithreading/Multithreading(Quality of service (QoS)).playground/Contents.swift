import Foundation

//создание потока
var pthread = pthread_t(bitPattern: 0)
var attribute = pthread_attr_t()
pthread_attr_init(&attribute)


//QOS_CLASS_USER_INTERACTIVE - интеснивная обработка (быстрая) высокий приоритет
//QOS_CLASS_USER_INITIATED - пользователь просит что-то сделать, но готов подождать
//QOS_CLASS_DEFAULT - что-то посередине, дефолтная загрузка
//QOS_CLASS_UTILITY - запуск для длительной загрузки, под копотом (не влияет на UI)
//QOS_CLASS_BACKGROUND - в фоновом режиме
//QOS_CLASS_UNSPECIFIED

pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_USER_INITIATED, 0)

pthread_create(&pthread, &attribute, {(pointer) -> UnsafeMutableRawPointer? in
    print("test1")
    pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)
    return nil
}, nil)



let nsThread = Thread {
    print("test123")
    print(qos_class_self())
}
nsThread.qualityOfService = .userInteractive
nsThread.start()


print(qos_class_main())
