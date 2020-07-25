
import UIKit

class JoinViewController: BaseViewController {

    @IBOutlet weak var headerTopSpace: NSLayoutConstraint!
    
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var emailWarningLabel: UILabel!
    
    var keyboardFrame: CGRect = .zero
    
    static func create() -> JoinViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "JoinViewController") as! JoinViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerObserver()
        self.setupLeftItemButton()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateNavigationBarAsTransparent()
    }
    
    func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    @IBAction func joinButtonDidTap(_ sender: Any) {
        let viewController = ProfileSetupViewController.create()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            self.keyboardFrame = keyboardFrame
        }
        self.headerTopSpace.constant = 30
        let rate = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: rate ?? 0.25, animations: {
            self.view.layoutIfNeeded()
        })
        
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        self.headerTopSpace.constant = 70
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

