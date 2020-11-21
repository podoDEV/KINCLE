
import UIKit
import Combine

class JoinViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var headerTopSpace: NSLayoutConstraint!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var emailWarningLabel: UILabel!
    
    @IBOutlet weak var pwTextField: UITextField!
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
        self.setupTextField()
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
        [self.emailWarningLabel, self.passwordWarningLabel].forEach {
            $0?.text = nil
            $0?.textColor = UIColor(hex: "#ff0000")
            $0?.font = UIFont.systemFont(ofSize: 11, weight: .light)
        }
        
        self.joinButton.isUserInteractionEnabled = false
        self.joinButton.backgroundColor = UIColor(hex: "#dbdbdb")
        self.joinButton.layer.cornerRadius = 11
        let title = NSAttributedString(string: "회원가입", attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.white
                
        ])
        self.joinButton.setAttributedTitle(title, for: .normal)
    }
    
    func setupTextField() {
        self.emailTextField.delegate = self
        self.pwTextField.delegate = self
        #if DEBUG
        self.emailTextField.text = "test@gmail.com"
        self.pwTextField.text = "podo123!@#"
        self.updateJoinButton(isEnable: true)
        #endif
    }
    
    @IBAction func joinButtonDidTap(_ sender: Any) {
        guard let email = self.emailTextField.text, let password = self.pwTextField.text else { return }
        let viewController = ProfileSetupViewController.create(email: email, password: password)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func updateJoinButton(isEnable: Bool) {
        self.joinButton.backgroundColor = isEnable ? App.Color.accent : UIColor(hex: "#dbdbdb")
        self.joinButton.isUserInteractionEnabled = isEnable
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        switch sender {
        case self.emailTextField:
            self.updateEmailWarningIfNeeded(text: nil)
        case self.pwTextField, _:
            self.updatePwWarningIfNeeded(text: nil)
            let warningText = isValidPw(of: text)
            if warningText == nil, self.emailWarningLabel.text == nil {
                self.updateJoinButton(isEnable: true)
            } else {
                self.updateJoinButton(isEnable: false)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        switch textField {
        case self.emailTextField:
            let warningText = self.isValidEmail(of: text)
            self.updateEmailWarningIfNeeded(text: warningText)
            return warningText == nil
        case self.pwTextField, _:
            let warningText = self.isValidPw(of: text)
            self.updatePwWarningIfNeeded(text: warningText)
            return warningText == nil
        }
    }
  
    func updateEmailWarningIfNeeded(text: String?) {
        self.emailWarningLabel.text = text
    }
    
    func updatePwWarningIfNeeded(text: String?) {
        self.passwordWarningLabel.text = text
    }
     
    func isValidEmail(of email: String) -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValid = emailPred.evaluate(with: email)
        if isValid {
            return nil
        } else {
            return "올바른 이메일 형식으로 입력해 주세요"
        }
    }
    
    func isValidPw(of text: String) -> String? {
        let pwRegEx = "^(?=.*[a-z])(?=.*[0-9]).{8,}$"
        let pwPred = NSPredicate(format:"SELF MATCHES %@", pwRegEx)
        let isValid = pwPred.evaluate(with: text)
        if isValid {
            return nil
        } else {
            return "숫자와 영문 조합 8자리 이상 사용해주세요"
        }
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
