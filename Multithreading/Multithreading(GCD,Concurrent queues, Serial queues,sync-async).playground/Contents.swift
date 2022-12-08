import UIKit
import PlaygroundSupport

//class QueueTest1 {
//    private let serialQueue = DispatchQueue(label: "serialTest")
//    private let concurrentQueue = DispatchQueue(label: "concurrentTest", attribute: .concurrent)
//}
//
//class QueueTest2 {
//    private let globalQueue = DispatchQueue.global()
//    private let mainQueue = DispatchQueue.main
//}

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = 
    }
}


let vc = MyViewController()
let navbar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.lineView = navbar
