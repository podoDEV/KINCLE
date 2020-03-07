
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = UIImage.SymbolConfiguration(weight: .thin)
        
        let image = UIImage(named: "zedd.heart")
        let thinImage = image?.withConfiguration(configuration)
        
        //self.myImageView.image = thinImage
        // Do any additional setup after loading the view.
    }
}
