import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
var image = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
image.backgroundColor = UIColor.yellow
image.contentMode = .scaleAspectFit
view.addSubview(image)


PlaygroundPage.current.liveView = view
func fetchImage() {
    
    let imageURL: URL = URL(string: "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
    let queue = DispatchQueue.global(qos: .utility)
    queue.async{
        if let data = try? Data(contentsOf: imageURL){
            DispatchQueue.main.async {
                image.image = UIImage(data: data)
                 print("Show image data")
            }
            print("Did download  image data")
        }
    }
}
fetchImage()

