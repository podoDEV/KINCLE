
import UIKit

class MainTabViewController: UIViewController {
    
    enum Tab: Int {
        case problem
        case myPage
    }
    
    @IBOutlet weak var myPageTabButton: UIButton!
    @IBOutlet weak var gymTabButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var selectedTab: Tab = .problem
    
    var viewControllers: [UIViewController] = []
    
    static func create() -> MainTabViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MainTabViewController") as! MainTabViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.backgroundColor = .blue
        let normalAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10, weight: .light),
            .foregroundColor: UIColor(hex: "#ababab")
        ]
        
        let selectedAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10, weight: .light),
            .foregroundColor: UIColor(hex: "#ababab")
        ]
        
        self.gymTabButton.setAttributedTitle(NSAttributedString(string: "암장", attributes: normalAttribute), for: .normal)
        self.myPageTabButton.setAttributedTitle(NSAttributedString(string: "마이페이지", attributes: normalAttribute), for: .normal)
        self.gymTabButton.setAttributedTitle(NSAttributedString(string: "암장", attributes: selectedAttribute), for: .selected)
        self.myPageTabButton.setAttributedTitle(NSAttributedString(string: "마이페이지", attributes: selectedAttribute), for: .selected)
        
        self.gymTabButton.alignImageAndTitleVertically(padding: 0)
        self.myPageTabButton.alignImageAndTitleVertically(padding: 0)
        
        let problemViewController = ProblemViewController.create()
        let myPageViewController = UIViewController()
        
        self.viewControllers = [problemViewController, myPageViewController]
        self.updateMainView(to: .problem)
    }
    
    @IBAction func gymButtonDidTap(_ sender: UIButton) {
        self.updateMainView(to: .problem)
    }
    
    @IBAction func myPageButtonDidTap(_ sender: UIButton) {
        self.updateMainView(to: .myPage)
    }
    
    func updateMainView(to tab: Tab) {
        let viewController = self.viewControllers[tab.rawValue]
        let previous = self.viewControllers[self.selectedTab.rawValue]
        previous.willMove(toParent: nil)
        previous.view.removeFromSuperview()
        previous.removeFromParent()
        
        self.selectedTab = tab
        self.addChild(viewController)
        self.containerView.addSubview(viewController.view)
        viewController.view.frame = self.containerView.bounds
        viewController.didMove(toParent: self)
        
        switch tab {
        case .problem:
            self.gymTabButton.isSelected = true
            self.myPageTabButton.isSelected = false
        case .myPage:
            self.gymTabButton.isSelected = false
            self.myPageTabButton.isSelected = true
        }
    }
}

extension UIButton {
    
    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
        guard let image = self.imageView?.image, let titleLabel = self.titleLabel, let titleText = titleLabel.text else { return }
        let titleSize = titleText.size(withAttributes: [
            .font: titleLabel.font
        ])
        
        self.titleEdgeInsets = UIEdgeInsets(top: padding, left: -image.size.width, bottom: -image.size.height, right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + padding), left: 0, bottom: 0, right: -titleSize.width)
    }
}
