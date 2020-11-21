//
//  BaseViewController.swift
//  KINCLE
//
//  Created by Zedd on 2020/06/27.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit

protocol FadeNavigationPresentable where Self: BaseViewController {
    
    var titleView: FadeTitleButton! { get set }
}

extension FadeNavigationPresentable {
    
    func setupFadeNavigationTitle(title: String?) {
        let titleView = FadeTitleButton()
        titleView.titleText = title ?? ""
        self.titleView = titleView
        self.navigationItem.titleView = titleView
    }
    
    func updateTitle(_ scrollView: UIScrollView, forceShow: Bool = false, needAnimation: Bool = true) {
        let isShowNavigationTitle: Bool = {
            if forceShow {
                return true
            } else {
                return scrollView.contentOffset.y > 44
            }
        }()
        
        let isShowNavigationShadow: Bool = {
            if forceShow {
                return true
            } else {
                return scrollView.contentOffset.y > 0
            }
        }()
        
        UIView.setAnimationsEnabled(needAnimation)
        UIView.animate(withDuration: 0.2) {
            let currentAlpha: CGFloat = isShowNavigationTitle ? 1 : 0
            self.titleView.updateAlpha(currentAlpha)
        }
        UIView.setAnimationsEnabled(true)
        
        if isShowNavigationShadow {
            self.updateNavigationBarAsDefault()
        } else {
            self.updateNavigationBarAsTransparent()
        }
    }
    
    func updateTitleAsDefault() {
        self.titleView.updateAlpha(1)
    }
}

class FadeTitleButton: UIButton {
    
    var didTap: (() -> Void)?
    
    let titleAttribute: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 19, weight: .medium),
        .foregroundColor: UIColor.black
    ]
    
    var titleText: String = "안녕하세요" {
        willSet {
            self.setAttributedTitle(NSAttributedString(string: newValue, attributes: self.titleAttribute), for: .normal)
            self.sizeToFit()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        self.updateAlpha(0)
        self.titleLabel?.lineBreakMode = .byTruncatingTail
    }
    
    func updateAlpha(_ alpha: CGFloat) {
        self.titleLabel?.alpha = alpha
        self.imageView?.alpha = alpha
    }
}

class BaseViewController: UIViewController {
    
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("- deinit \(type(of: self))")
    }
    
    func updateNavigationBarAsTransparent() {
        if #available(iOS 13, *) {
            self.navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()
            self.setNeedsStatusBarAppearanceUpdate()
            self.navigationController?.navigationBar.standardAppearance.shadowColor = nil
            self.navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
            if let attributes = UINavigationBar.appearance().titleTextAttributes {
                self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = attributes
            }
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.barTintColor = .clear
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    func updateNavigationBarAsDefault() {
        if #available(iOS 13, *) {
            self.navigationController?.navigationBar.standardAppearance.shadowColor = UIColor(hex: "#dddddd")
            self.navigationController?.navigationBar.standardAppearance.backgroundColor = .white
            if let attributes = UINavigationBar.appearance().titleTextAttributes {
                self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = attributes
            }
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.setBackgroundImage(UIColor.white.asImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage.navigationShadow
        }
    }
    
    func setupLeftItemButton() {
        if self.isModal {
            let image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysOriginal)
            let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.close))
            self.navigationItem.leftBarButtonItem = item
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
    
    @objc
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIColor {
    
    func asImage() -> UIImage {
        let size = CGSize(width: 1 / UIScreen.main.scale, height: 1 / UIScreen.main.scale)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.setFill()
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsGetCurrentContext()?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIImage {
    
    static var navigationShadow: UIImage {
        return UIColor(hex: "#dddddd").asImage()
    }
}

