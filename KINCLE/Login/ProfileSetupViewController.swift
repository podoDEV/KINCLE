//
//  ProfileSetupViewController.swift
//  KINCLE
//
//  Created by Zedd on 2020/06/27.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit

class ProfileSetupViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var levelPicker: UIPickerView!
    
    @IBOutlet weak var levelDescriptionButton: UIButton!
    
    @IBOutlet weak var completeButton: UIButton!
    
    static func create() -> ProfileSetupViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewControlelr = storyboard.instantiateViewController(identifier: "ProfileSetupViewController") as! ProfileSetupViewController
        return viewControlelr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLeftItemButton()
        self.setupLevelPicker()
        self.addGestureRecognizer()
        self.registerObservers()
    }
    
    func setupLevelPicker() {
        self.levelPicker.delegate = self
        self.levelPicker.dataSource = self
        let title = NSAttributedString(string: "내 레벨을 모르겠다면?", attributes: [
            .font: UIFont.systemFont(ofSize: 12, weight: .light),
            .foregroundColor: UIColor(hex: "9b9b9b"),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        self.levelDescriptionButton.setAttributedTitle(title, for: .normal)
        self.levelPicker.reloadAllComponents()
        self.levelPicker.selectRow(2, inComponent: 0, animated: true)
    }
    
    func addGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.tableView.addGestureRecognizer(tap)
    }
    
    func registerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func searchFavoriteGymButtonDidTap(_ sender: Any) {
        let viewController = SearchFavoriteGymViewController.create()
        let navigation = UINavigationController(rootViewController: viewController)
        self.present(navigation, animated: true, completion: nil)
    }
    
    @IBAction func levelDescriptionButtonDidTap(_ sender: Any) {
        let view = UIImageView()
        
    }
    
    @IBAction func completeButtonDidTap(_ sender: Any) {
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            self.tableView.contentInset.bottom = keyboardFrame.height
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        self.tableView.contentInset.bottom = 0
    }
}
extension ProfileSetupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Level. \(row + 1)"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
}
