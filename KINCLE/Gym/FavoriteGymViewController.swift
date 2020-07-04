
import UIKit
import SnapKit
import Combine

class FavoriteGymViewModel {
    
    @Published var favoriteGyms: [Gym] = [Gym(), Gym(),Gym(), Gym(),Gym(), Gym(),Gym(), Gym()]
    var cancellable: AnyCancellable?
    
    func requestFavoriteGyms() {
//        self.cancellable = ApiManager.shared.requestFavoriteGyms()?
//            .assign(to: \.favoriteGyms, on: self)
    }
}

class FavoriteGymViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var subscriptions = [AnyCancellable]()

    var viewModel: FavoriteGymViewModel = FavoriteGymViewModel()
    
    static func create() -> FavoriteGymViewController {
        let storyboard = UIStoryboard(name: "Gym", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FavoriteGymViewController") as! FavoriteGymViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.viewModel.requestFavoriteGyms()
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(FavoriteGymCountCollectionViewCell.self, forCellWithReuseIdentifier: "FavoriteGymCountCollectionViewCell")
    }
}

extension FavoriteGymViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum Section: Int, CaseIterable {
        
        case count
        case gym
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .count:
            return 1
        case .gym:
            return self.viewModel.favoriteGyms.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .count:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteGymCountCollectionViewCell", for: indexPath) as! FavoriteGymCountCollectionViewCell
            cell.configure(count: self.viewModel.favoriteGyms.count)
            return cell
        case .gym:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteGymCollectionViewCell", for: indexPath) as! FavoriteGymCollectionViewCell
            cell.configure(gym: self.viewModel.favoriteGyms[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch Section(rawValue: section)! {
        case .count:
            return 0
        case .gym:
            return 16
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch Section(rawValue: section)! {
        case .count:
            return .zero
        case .gym:
            return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        }
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
        let width: CGFloat
        let height: CGFloat
        switch Section(rawValue: indexPath.section)! {
        case .count:
            width = collectionView.frame.width
            height = 48
        case .gym:
            width = (collectionView.frame.width - 15 - 32) / 2
            height = 200
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch Section(rawValue: section)! {
        case .count:
            let width: CGFloat = collectionView.frame.width
            let height: CGFloat = 244
            return CGSize(width: width, height: height)
        case .gym:
            return .zero
        }
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

class FavoriteGymCountCollectionViewCell: UICollectionViewCell {
    
    weak var countLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let label = UILabel()
        label.text = "안녕"
        self.countLabel = label
        self.contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.trailing.equalTo(20)
            $0.centerY.equalToSuperview()
            
        }
    }
    
    func configure(count: Int) {
        let title = "총 \(count)개의 암장"
        let attributedText = NSMutableAttributedString(string: title, attributes: [
            .font: UIFont.systemFont(ofSize: 13, weight: .light),
            .foregroundColor: App.Color.titleText
        ])
        let range = (title as NSString).range(of: "\(count)")
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .bold), range: range)
        self.countLabel?.attributedText = attributedText
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
