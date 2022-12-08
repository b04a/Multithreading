//
//  TwoViewController.swift
//  Multithreading(GCD Async After, Concurrent Perform, Initially Inactive)
//
//  Created by Danil Bochkarev on 08.12.2022.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        for i in 0...2000 {
//            print(i)
//        }
 
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            DispatchQueue.concurrentPerform(iterations: 200000) {
//                print("\($0) timees")
//                print(Thread.current)
//            }
//        }
        myInactiveQueue()
        
        func myInactiveQueue() {
            let inactiveQueue = DispatchQueue(label: "Future+", attributes: [.concurrent, .initiallyInactive])
            
            inactiveQueue.async {
                print("DONE!")
            }
            
            print("Not yet startet...")
            inactiveQueue.activate()
            print("Activate!")
            inactiveQueue.suspend()
            print("Suspend!")
            inactiveQueue.resume()
            print("Resume!")
        }
        
    }
}
