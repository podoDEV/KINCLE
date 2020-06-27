//
//  BaseViewController.swift
//  KINCLE
//
//  Created by Zedd on 2020/06/27.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
                let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
                let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

                return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupLeftItemButton() {
        if self.isModal {
            
        } else {
            let image = UIImage(named: "navigation_back_black")?.withRenderingMode(.alwaysOriginal)
            let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.backButtonDidTap))
            self.navigationItem.leftBarButtonItem = item
        }
    }
    
    @objc
    func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }

}
