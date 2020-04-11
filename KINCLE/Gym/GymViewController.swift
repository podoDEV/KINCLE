//
//  GymViewController.swift
//  KINCLE
//
//  Created by Zedd on 2020/04/03.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit

class FavoriteGymViewModel {
    
    var favoriteGyms: [Gym] = [Gym(), Gym(),Gym(), Gym(),Gym(), Gym(),Gym(), Gym()]
}

class GymViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: FavoriteGymViewModel = FavoriteGymViewModel()
    
    static func create() -> GymViewController {
        let storyboard = UIStoryboard(name: "Gym", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GymViewController") as! GymViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHeaderView()
        self.setupCollectionView()
    }
    
    func setupHeaderView() {
//        self.findGymButton.backgroundColor = UIColor(hex: "#f2f2f2")
//        self.findGymButton.layer.cornerRadius = 6
//        self.findGymButton.layer.borderColor = UIColor(hex: "#ececec").cgColor
//        self.findGymButton.layer.borderWidth = 1
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // cell이 superView에 닿게.
        self.collectionView.contentInsetAdjustmentBehavior = .never
    }
}

extension GymViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y >= 0 {
//            self.headerView.clipsToBounds = true
//            self.headerImageViewBottomSpace.constant = -scrollView.contentOffset.y / 2
//            self.headerImageViewTopSpace.constant = scrollView.contentOffset.y / 2
//        } else {
//            self.headerImageViewTopSpace.constant = scrollView.contentOffset.y
//            self.headerView.clipsToBounds = false
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 30
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteGymCollectionViewCell", for: indexPath) as! FavoriteGymCollectionViewCell
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//            return CGSize(width: collectionView.frame.width, height: 180.0)
//    }
}

class FavoriteGymCollectionViewCell: UICollectionViewCell {
//    @IBOutlet weak var mainImageView: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var addressLabel: UILabel!
//    @IBOutlet weak var isFavoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //self.mainImageView.image = UIImage(named: "default_gym_image")
    }
    
//    func setupViews() {
//        self.mainImageView.layer.cornerRadius = 12
//        self.mainImageView.contentMode = .scaleAspectFill
//        self.mainImageView.clipsToBounds = true
//
//        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
//        self.nameLabel.textColor = App.Color.titleText
//
//        self.isFavoriteButton.setImage(UIImage(named: "favorite_gym_off"), for: .normal)
//        self.isFavoriteButton.setImage(UIImage(named: "favorite_gym_on"), for: .selected)
//    }
//
//    func configure(gym: Gym) {
//        self.nameLabel.text = gym.name
//        self.addressLabel.text = gym.address
//        self.isFavoriteButton.isSelected = gym.isFavorite
//    }
}
