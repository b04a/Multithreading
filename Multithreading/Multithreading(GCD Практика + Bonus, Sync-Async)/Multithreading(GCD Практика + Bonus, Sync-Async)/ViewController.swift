//
//  ViewController.swift
//  Multithreading(GCD Практика + Bonus, Sync-Async)
//
//  Created by Danil Bochkarev on 08.12.2022.
//

import UIKit
import PlaygroundSupport


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "vc 1"
        
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}


let vc = ViewController()
let navbar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.lineView = navbar
