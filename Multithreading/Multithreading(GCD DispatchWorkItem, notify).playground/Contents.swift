import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Wort Item"

class DispatchWorkItem1 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
    
    func create() {
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start task")
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("task end")
        }
        
        queue.async(execute: workItem)
    }
}

class DispatchWorkItem2 {
    private let queue = DispatchQueue(label: "DispatchWorkItem2")
    
    func create() {
        queue.async {
            sleep(1)
            print(Thread.current)
            print("task1")
        }
        
        queue.async {
            sleep(1)
            print(Thread.current)
            print("task2")
        }
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start work item task3")
        }
        
        queue.async(execute: workItem)
        workItem.cancel()
    }
}


//let dispatchWorkItem2 = DispatchWorkItem2()
//dispatchWorkItem2.create()

var view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 220))
var rockImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

rockImage.backgroundColor = UIColor.yellow
rockImage.contentMode = .scaleAspectFit
rockImage.center = view.center
view.addSubview(rockImage)

PlaygroundPage.current.liveView = view

let imageURL = URL(string: "https://moya-planeta.ru/upload/images/xl/95/fe/95fe44d0e5fe53e49d874f9c2e07381ca8ea823a.jpg")!

//classic
func fetchImage() {
    let queue = DispatchQueue.global(qos: .utility)
    
    queue.async {
        if let data = try? Data(contentsOf: imageURL) {
            DispatchQueue.main.async {
                rockImage.image = UIImage(data: data)
            }
        }
    }
}

//fetchImage()

//Dispath work item

func fetchImage2() {
    var data: Data?
    
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInteractive) {
        data = try? Data(contentsOf: imageURL)
        print(Thread.current)
    }
    
    queue.async(execute: workItem)
    
    workItem.notify(queue: DispatchQueue.main) {
        if let imageData = data {
            print(Thread.current)
            rockImage.image = UIImage(data: imageData)
        }
    }
}

//fetchImage2()

//URLSession

func fetchImage3() {
    let task = URLSession.shared.dataTask(with: imageURL) { data, resp, err in
        print(Thread.current)
        
        if let imageData = data {
            DispatchQueue.main.async {
                print(Thread.current)
                rockImage.image = UIImage(data: imageData)
            }
        }
    }
    task.resume()
}

fetchImage3()
