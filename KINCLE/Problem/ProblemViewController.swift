//
//  ProblemViewController.swift
//  KINCLE
//
//  Created by Zedd on 2020/05/02.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit

class Problem: Decodable {
    
    var level: Int
    var title: String
    var submitter: String
    var timestamp: Double
    var imageURL: String
    var scrapCount: Int
    var likeCount: Int
    var commentCount: Int
}

class ProblemViewModel {
    
}
class ProblemViewController: UIViewController {

    @IBOutlet weak var levelContainerView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var submitterLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    static func create() -> ProblemViewController {
        let storyboard = UIStoryboard(name: "Problem", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ProblemViewController") as! ProblemViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHeaderView()
        self.setupStartButton()

    }
    
    func setupHeaderView() {
        self.levelContainerView.layer.cornerRadius = 6
        self.levelContainerView.clipsToBounds = true
        self.levelContainerView.backgroundColor = UIColor(hex: "#00d9d1").withAlphaComponent(0.15)
        self.levelLabel.textColor = UIColor(hex: "#07bcbc")
        self.levelLabel.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        self.imageView.backgroundColor = UIColor(hex: "#eeeeee")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        let attributedTitleString = NSMutableAttributedString(string: "클라이밍 처음 시작하는 초보자분들 주목!\n이 문제부터 도전하세요!", attributes: [
            .font: UIFont.systemFont(ofSize: 17, weight: .bold),
            .paragraphStyle: paragraphStyle
        ])
        self.titleLabel.attributedText = attributedTitleString
    }
    
    func setupStartButton() {
        self.startButton.backgroundColor = UIColor(hex: "#00d9d1")
        let attributedString = NSAttributedString(string: "문제 시작하기", attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.white
        ])
        self.startButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    func updateHeaderView() {
//        let attributedString = NSMutableAttributedString(string: <#T##String#>, attributes: <#T##[NSAttributedString.Key : Any]?#>)
//        self.submitterLabel.attributedText
    }
}

extension UITableViewDelegate {
    
}
