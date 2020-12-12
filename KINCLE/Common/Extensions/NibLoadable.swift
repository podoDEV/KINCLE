//
//  NibLoadable.swift
//  KINCLE
//
//  Created by Zedd on 2020/12/05.
//  Copyright © 2020 Zedd. All rights reserved.
//
import UIKit

protocol NibLoadable: class {
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: T.id)
    }
}

extension UITableViewCell: NibLoadable, ReusableCell {}

protocol ReusableCell: class {
    static var id: String { get }
}

extension ReusableCell {
    
    static var id: String {
        return String(describing: self)
    }
}
