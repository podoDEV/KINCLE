
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
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension GymViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.favoriteGyms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteGymCollectionViewCell", for: indexPath) as! FavoriteGymCollectionViewCell
        cell.configure(gym: self.viewModel.favoriteGyms[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FavoriteGymHeaderReusableView", for: indexPath) as! FavoriteGymHeaderReusableView
            return headerView
        default:
            assert(false, "wrong viewForSupplementaryElement type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 15 - 32) / 2
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 244
        return CGSize(width: width, height: height)
    }
}

class FavoriteGymHeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var findGymButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupView() {
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        self.subtitleLabel.textColor = UIColor(hex: "#b2bac2")
        self.titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        self.titleLabel.textColor = App.Color.titleText
        self.findGymButton.backgroundColor = UIColor(hex: "#f2f2f2")
        self.findGymButton.layer.cornerRadius = 6
        self.findGymButton.layer.borderColor = UIColor(hex: "#ececec").cgColor
        self.findGymButton.layer.borderWidth = 1
        self.findGymButton.setAttributedTitle(NSAttributedString(string: "암장 찾기", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 10),
            .foregroundColor: App.Color.titleText
        ]), for: .normal)
    }
}

class FavoriteGymCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var isFavoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.mainImageView.image = UIImage(named: "default_gym_image")
    }
    
    func setupViews() {
        self.mainImageView.image = UIImage(named: "default_gym_image")
        self.mainImageView.layer.cornerRadius = 12
        self.mainImageView.contentMode = .scaleAspectFill
        self.mainImageView.clipsToBounds = true
        
        self.nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        self.nameLabel.textColor = App.Color.titleText
        self.addressLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        self.addressLabel.textColor = UIColor(hex: "#ababab")
        // selected상태에서 backgroundColor가 들어가는 걸 막아주기 위해서.
        self.isFavoriteButton.adjustsImageWhenHighlighted = false
        self.isFavoriteButton.setImage(UIImage(named: "favorite_gym_off")?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.isFavoriteButton.setImage(UIImage(named: "favorite_gym_on")?.withRenderingMode(.alwaysOriginal), for: .selected)
    }
    
    func configure(gym: Gym) {
        self.nameLabel.text = gym.name
        self.addressLabel.text = gym.address
        self.isFavoriteButton.isSelected = gym.isFavorite
    }
}

class StretchableCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        
        guard let offset = collectionView?.contentOffset, let stLayoutAttributes = layoutAttributes else {
            return layoutAttributes
        }
        if offset.y < 0 {
            
            for attributes in stLayoutAttributes {
                
                if let elmKind = attributes.representedElementKind, elmKind == UICollectionView.elementKindSectionHeader {
                    
                    let diffValue = abs(offset.y)
                    var frame = attributes.frame
                    frame.size.height = max(0, headerReferenceSize.height + diffValue)
                    frame.origin.y = frame.minY - diffValue
                    attributes.frame = frame
                }
            }
        }
        return layoutAttributes
    }
}
