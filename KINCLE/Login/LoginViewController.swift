//
//  LoginViewController.swift
//  KINCLE
//
//  Created by Zedd on 2020/05/16.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit
import SnapKit
import AuthenticationServices

class LoginViewController: BaseViewController {

    @IBOutlet weak var headerTopSpace: NSLayoutConstraint!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotInfoButton: UIButton!
    
    @IBOutlet weak var appleLoginContainerView: UIView!
    
    var keyboardFrame: CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFields()
        self.setupLoginButton()
        self.setupAppleLoginButton()
        self.setupButtons()
        self.registerNofitifcations()
        self.updateNavigationBarAsTransparent()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func setupTextFields() {
        [self.idTextField, self.passwordTextField].forEach {
            $0?.borderStyle = .none
        }
        
        self.idTextField.placeholder = "아이디를 입력하세요."
        self.passwordTextField.placeholder = "비밀번호를 입력하세요."
        self.passwordTextField.isSecureTextEntry = true
    }
    
    func setupLoginButton() {
        self.loginButton.setAttributedTitle(NSAttributedString(string: "로그인", attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.white
        ]), for: .normal)
        self.loginButton.backgroundColor = UIColor(hex: "#dbdbdb")
        self.loginButton.layer.cornerRadius = 12
    }
    
    func setupAppleLoginButton() {
        let button = ASAuthorizationAppleIDButton()
        self.appleLoginContainerView.addSubview(button)
        self.appleLoginContainerView.clipsToBounds = true
        button.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        self.appleLoginContainerView.layer.cornerRadius = 12
    }
    
    func setupButtons() {
        let signUpTitle = NSAttributedString(string: "회원가입", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .light),
            .foregroundColor: UIColor(hex: "#9b9b9b"),
            .underlineColor: UIColor(hex: "#9b9b9b"),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        let forgotTitle = NSAttributedString(string: "아이디/비밀번호 찾기", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .light),
            .foregroundColor: UIColor(hex: "#9b9b9b"),
            .underlineColor: UIColor(hex: "#9b9b9b"),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        self.signUpButton.setAttributedTitle(signUpTitle, for: .normal)
        self.forgotInfoButton.setAttributedTitle(forgotTitle, for: .normal)
    }
    
    func registerNofitifcations() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func signUpButtonDidTap(_ sender: Any) {
        let viewController = JoinViewController.create()
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

extension LoginViewController: UITextFieldDelegate {
    
}
