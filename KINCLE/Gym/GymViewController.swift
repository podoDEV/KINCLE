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
        self.tableView.contentInset = UIEdgeInsets(top: 430, left: 0, bottom: 0, right: 0)
        self.tableView.backgroundColor = .clear
    }
}

extension GymViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let offset = scrollView.contentOffset.y
//
//         if(offset > 200){
//             self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 0)
//         } else {
//             self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 200 - offset)
//         }
//
//         let rect = CGRect(x: 0, y: self.headerView.frame.maxY, width: self.view.bounds.size.width, height: (self.tableView.bounds.size.height - (self.headerView.frame.maxY)))
//            self.tableView.frame = rect
     }
}
