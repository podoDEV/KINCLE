
import UIKit

class MainTabViewController: BaseViewController {
    
    enum Tab: Int {
        case problem
        case myPage
    }
    
    @IBOutlet weak var tabContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tabContainerView: UIView!
    @IBOutlet weak var myPageTabButton: UIButton!
    @IBOutlet weak var gymTabButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addProblemButton: UIButton!
    
    override var navigationItem: UINavigationItem {
        guard self.viewControllers.count > 0 else { return super.navigationItem }
        return self.viewControllers[self.selectedTab.rawValue].navigationItem
    }
    
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
        self.tabContainerViewHeight.constant = 48 + Device.safeAreaBottomInset
        self.tabContainerView.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        let topLineView = UIView()
        topLineView.backgroundColor = UIColor(hex: "#bebebe")
        self.view.addSubview(topLineView)
        self.view.bringSubviewToFront(self.addProblemButton)
        
        topLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.tabContainerView.snp.top)
            $0.height.equalTo(0.5)
        }
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
        
        let gymController = GymTabViewController.create()
        let myPageViewController = MyPageViewController.create()
        
        self.viewControllers = [gymController, myPageViewController]
        self.updateMainView(to: .problem)
    }
    
    @IBAction func gymButtonDidTap(_ sender: UIButton) {
        self.updateMainView(to: .problem)
    }
    
    @IBAction func myPageButtonDidTap(_ sender: UIButton) {
        self.updateMainView(to: .myPage)
    }
    
    @IBAction func addButtonDidTap(_ sender: Any) {
        let viewController = ProblemViewController.create()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: true, completion: nil)
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
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
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
            .font: titleLabel.font!
        ])
        
        self.titleEdgeInsets = UIEdgeInsets(top: padding, left: -image.size.width, bottom: -image.size.height, right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + padding), left: 0, bottom: 0, right: -titleSize.width)
    }
}

public struct Device { }

extension Device {
    
    public static var safeAreaTopInset: CGFloat {
        return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
    }
    
    public static var safeAreaBottomInset: CGFloat {
        return  UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
    }
}

