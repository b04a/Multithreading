import UIKit
import PlaygroundSupport



// Выполнение группы через последовательную очередь
class DispatchGroupTest1 {
    private let queueSerial = DispatchQueue(label: "future hendrix")
    
    private let groupRed = DispatchGroup()
    
    
    func loadInfo() {
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("1")
        }
        
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("2")
        }
        
        groupRed.notify(queue: .main) {
            print("end all")
        }
    }
}

//let dispatchGroupTest1 = DispatchGroupTest1()
//dispatchGroupTest1.loadInfo()

// Выполнение группы через параллельную
class DispatchGroupTest2 {
    private let queueConc = DispatchQueue(label: "future hendrix", attributes: .concurrent)
    
    private let groupBlack = DispatchGroup()
    
    func loadInfo() {
        groupBlack.enter()
        queueConc.async {
            sleep(1)
            print("1")
            self.groupBlack.leave()
        }
        
        groupBlack.enter()
        queueConc.async {
            sleep(2)
            print("2")
            self.groupBlack.leave()
        }
        
        groupBlack.wait()
        
        print("end all")
        
        groupBlack.notify(queue: .main) {
            print("groupBlack end all")
        }
    }
}

//let dispatchGroupTest2 = DispatchGroupTest2()
//dispatchGroupTest2.loadInfo()

class EImage: UIView {
    public var ivs = [UIImageView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)))
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 50, height: 50)))
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 200, width: 50, height: 50)))
        
        
        
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 50, height: 50)))
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 50, height: 50)))
        
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 200, width: 50, height: 50)))
        
        for i in 0...5 {
            ivs[i].contentMode = .scaleAspectFit
            self.addSubview(ivs[i])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("bebra")
    }
}

var view = EImage(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.backgroundColor = UIColor.white

let imageURLs = ["https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "https://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png", "https://natworld.info/wp-content/uploads/2020/04/gora-fudzi.jpg"]

var images = [UIImage]()

PlaygroundPage.current.liveView = view

func asyncLoadImage(imageURL: URL, runQueue: DispatchQueue, conpletionQueue: DispatchQueue, completion: @escaping (UIImage?, Error?) -> ()) {
    runQueue.async {
        do {
            let data = try Data(contentsOf: imageURL)
            conpletionQueue.async {
                completion(UIImage(data: data), nil)
            }
        } catch let error {
            conpletionQueue.async {
                completion(nil, error)
            }
        }
    }
}

func asyncGroup() {
    let aGroup = DispatchGroup()
    
    for i in 0...2 {
        aGroup.enter()
        asyncLoadImage(imageURL: URL(string: imageURLs[i])!,
                       runQueue: .global(),
                       conpletionQueue: .main) { result, err in
            guard let image1 = result else { return }
            images.append(image1)
            aGroup.leave()
        }
    }
    
    aGroup.notify(queue: .main) {
        for i in 0...2 {
            view.ivs[i].image = images[i]
        }
    }
}

func asyncUrlSession() {
    for i in 3...5 {
        let url = URL(string: imageURLs[i - 3])
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, resp, err) in
            DispatchQueue.main.async {
                view.ivs[i].image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}


asyncUrlSession()

//asyncGroup()
