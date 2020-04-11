
import UIKit

class MainTabViewController: UITabBarController {
    
    lazy var homeViewController: UIViewController = {
        let viewController = HomeViewController()
        let item = UITabBarItem(title: "홈", image: UIImage(named: "tab_home"), selectedImage: nil)
        viewController.tabBarItem = item
        return viewController
    }()
    
    lazy var gymViewController: UIViewController = {
        let viewController = GymViewController.create()
        let item = UITabBarItem(title: "암장", image: UIImage(named: "tab_gym"), selectedImage: nil)
        viewController.tabBarItem = item
        return viewController
    }()
    
    lazy var networkViewController: UIViewController = {
        let viewController = CrewViewController()
        let item = UITabBarItem(title: "크루", image: UIImage(named: "tab_crew"), selectedImage: nil)
        viewController.tabBarItem = item
        return viewController
    }()
    
    lazy var profileViewController: UIViewController = {
        let viewController = ProfileViewController()
        let item = UITabBarItem(title: "프로필", image: nil, selectedImage: nil)
        viewController.tabBarItem = item
        return viewController
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.viewControllers = [self.homeViewController,
                                self.gymViewController,
                                self.networkViewController,
                                self.profileViewController]

    }
}
