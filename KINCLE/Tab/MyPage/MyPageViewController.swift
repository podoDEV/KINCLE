
import UIKit

class MyPageViewController: UIViewController {

    static func create() -> MyPageViewController {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MyPageViewController") as! MyPageViewController
        return viewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "마이 페이지"
        self.view.backgroundColor = .white
        let edit = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: #selector(editButtonDidTap))
        // Do any additional setup after loading the view.
    }
    
    @objc
    func editButtonDidTap() {
        
    }
}
