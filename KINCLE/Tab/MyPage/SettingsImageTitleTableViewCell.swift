//
//  SettingsImageTitleTableViewCell.swift
//  KINCLE
//
//  Created by Zedd on 2020/12/05.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit

class SettingsImageTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupView() {
        self.titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.countLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
    }
    
    func configure(configration: SettinsCellConfiguration) {
        self.myImageView.image = configration.image?.withRenderingMode(.alwaysOriginal)
        self.titleLabel.text = configration.title
        if let subtitle = configration.subtitle {
            self.countLabel.text = subtitle
        } else {
            self.countLabel.text = nil
        }
    }
}
