
import UIKit

class JoinViewController: BaseViewController {

    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var emailWarningLabel: UILabel!
    
    static func create() -> JoinViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "JoinViewController") as! JoinViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLeftItemButton()
        self.setupViews()

    }
    
    func setupViews() {
        self.emailWarningLabel.text = nil
        self.passwordWarningLabel.text = nil
        self.joinButton.backgroundColor = UIColor(hex: "#dbdbdb")
        self.joinButton.layer.cornerRadius = 11
        let title = NSAttributedString(string: "회원가입", attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.white
                
        ])
        self.joinButton.setAttributedTitle(title, for: .normal)
    }

}

extension UIViewController {
    
    func updateNavigationBarAsTransparent() {
        
        self.navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.standardAppearance.shadowColor = nil
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        if let attributes = UINavigationBar.appearance().titleTextAttributes {
            self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = attributes
        }
    }
    
    func updateNavigationBarAsDefault() {
        self.navigationController?.navigationBar.standardAppearance.shadowColor = UIColor(hex: "#dddddd")
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = .white
        if let attributes = UINavigationBar.appearance().titleTextAttributes {
            self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = attributes
        }
    }
}
