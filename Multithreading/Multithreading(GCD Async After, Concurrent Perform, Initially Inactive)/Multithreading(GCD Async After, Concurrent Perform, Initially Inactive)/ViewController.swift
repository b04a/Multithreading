//
//  ViewController.swift
//  Multithreading(GCD Async After, Concurrent Perform, Initially Inactive)
//
//  Created by Danil Bochkarev on 08.12.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        afterBlock(seconds: 4, Queue: .main) {
            print("Hello")
            self.showAlert()
            print(Thread.current)
        }
        
//        afterBlock(seconds: 2) {
//            print("Hello")
//            self.showAlert()
//            print(Thread.current)
//        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Hello, sir!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func afterBlock(seconds: Int, Queue: DispatchQueue = DispatchQueue.global(), complition: @escaping () -> ()) {
        Queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            complition()
        }
    }


}

