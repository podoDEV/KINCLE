//
//  GymViewController.swift
//  KINCLE
//
//  Created by Zedd on 2020/04/12.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit
import Combine

class GymViewController: UIViewController {
    
    @IBOutlet weak var dimmedView: UIView!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var gymIntoduceLabel: UILabel!
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // @IBOutlet weak var headerImageView: UIImageView!
    static func create() -> GymViewController {
        let storyboard = UIStoryboard(name: "Gym", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GymViewController") as! GymViewController
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInfoView()
        self.setupTableView()
    }
    
    func setupInfoView() {
        self.infoContainerView.backgroundColor = .clear
        self.dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        self.gymIntoduceLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.gymIntoduceLabel.textColor = UIColor.white
        [self.addressLabel, self.hoursLabel].forEach {
            $0?.font = UIFont.systemFont(ofSize: 13, weight: .light)
            $0?.textColor = UIColor.white
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.contentInset = UIEdgeInsets(top: 430 - 88, left: 0, bottom: 0, right: 0)
        self.tableView.backgroundColor = .clear
    }
}

extension GymViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum Section: Int, CaseIterable {
        
        case tab
        case filter
        case post
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .tab, .filter: return 1
        case .post: return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .tab:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GymTabTableViewCell") as! GymTabTableViewCell
            return cell
        case .filter:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GymCountFilterTableViewCell") as! GymCountFilterTableViewCell
            return cell
        case .post:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GymPostTableViewCell") as! GymPostTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Section(rawValue: indexPath.section)! {
        case .tab:
            return 54
        case .filter:
            return 40
        case .post:
            return 241
        }
    }
}
class GymTabTableViewCell: UITableViewCell {
    
}

class GymCountFilterTableViewCell: UITableViewCell {
    
}

class GymPostTableViewCell: UITableViewCell {
    
}
