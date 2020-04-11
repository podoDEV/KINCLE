//
//  ProfileViewController.swift
//  KINCLE
//
//  Created by Zedd on 2020/04/03.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static func create() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//                self.collectionView.delegate = self
//                self.collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZeddCollectionViewCell", for: indexPath) as! ZeddCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableView", for: indexPath)
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//            return CGSize(width: collectionView.frame.width, height: 180.0)
//    }
}

class ZeddCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
