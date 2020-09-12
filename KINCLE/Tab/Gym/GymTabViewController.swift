
import UIKit

class GymTabViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, FadeNavigationPresentable {
    
    var titleView: FadeTitleButton!
    
    enum Section: Int, CaseIterable {
        
        case title
        case bigCategory
        case filter
        case problem
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var arr: [String] = ["zedd","zedd","zedd","zedd","zedd","zedd","zedd"]
    
    static func create() -> GymTabViewController {
        let storyboard = UIStoryboard(name: "Gym", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "GymTabViewController") as! GymTabViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFadeNavigationTitle(title: "홍대 더클라임")
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateNavigationBarAsTransparent()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .title, .bigCategory, .filter:
            return 1
        case .problem:
            return self.arr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProblemTitleTableViewCell", for: indexPath) as! ProblemTitleTableViewCell
            cell.configure(currentGymTitle: "홍대 더클라임")
            return cell
        case .bigCategory:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProblemBigCategoryTableViewCell", for: indexPath) as! ProblemBigCategoryTableViewCell
            return cell
        case .filter:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProblemFilterTableViewCell", for: indexPath) as!  ProblemFilterTableViewCell
            cell.configure(totalCount: self.arr.count)
            return cell
        case .problem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProblemTableViewCell", for: indexPath) as! ProblemTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Section(rawValue: indexPath.section)! {
        case .title:
            return 33
        case .bigCategory:
            return 64
        case .filter:
            return 56
        case .problem:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateTitle(scrollView)
    }
}

enum Category {
    
    case problem
    case community
}

enum Order {
    
    case popular
    case latest
}

protocol GymCellDelegate {
    
    func showFavoriteGyms()
    func updatePostKind(with: Category)
    func shouldChangePostOrder(with: Order)
    func postDidTap(id: Int)
}

class ProblemTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(currentGymTitle: String) {
        let attribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.label
        ]
        self.titleButton.setAttributedTitle(NSAttributedString(string: currentGymTitle, attributes: attribute), for: .normal)
    }
    
    @IBAction func changeGymButtonDidTap(_ sender: Any) {
        
    }
}

class ProblemBigCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var problemButton: UIButton!
    @IBOutlet weak var communityButton: UIButton!
    
    weak var dotImageView1: UIImageView!
    weak var dotImageView2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupButtons()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupButtons() {
        let normalAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
            .foregroundColor: UIColor.tertiaryLabel
        ]
        let selectedAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
            .foregroundColor: UIColor.label
        ]
        
        self.problemButton.setAttributedTitle(NSAttributedString(string: "문제", attributes: normalAttribute), for: .normal)
        self.problemButton.setAttributedTitle(NSAttributedString(string: "문제", attributes: selectedAttribute), for: .selected)
        
        self.communityButton.setAttributedTitle(NSAttributedString(string: "커뮤니티", attributes: normalAttribute), for: .normal)
        self.communityButton.setAttributedTitle(NSAttributedString(string: "커뮤니티", attributes: selectedAttribute), for: .selected)
        self.problemButton.isSelected = true
        
        let dotImageView1 = UIImageView()
        dotImageView1.image = UIImage(named: "tab_select")
        let dotImageView2 = UIImageView()
        dotImageView2.image = UIImage(named: "tab_select")

        self.dotImageView1 = dotImageView1
        self.dotImageView2 = dotImageView2
        
        self.contentView.addSubview(self.dotImageView1)
        self.contentView.addSubview(self.dotImageView2)
        
        self.dotImageView1.snp.makeConstraints {
            $0.top.equalTo(self.problemButton.snp.bottom)
            $0.size.equalTo(CGSize(width: 4, height: 4))
            $0.centerX.equalTo(self.problemButton)
        }
        
        self.dotImageView2.snp.makeConstraints {
            $0.top.equalTo(self.communityButton.snp.bottom)
            $0.size.equalTo(CGSize(width: 4, height: 4))
            $0.centerX.equalTo(self.communityButton)
        }
        
        self.dotImageView2.isHidden = true
    }
    
    @IBAction func problemButtonDidTap(_ sender: Any) {
        self.problemButton.isSelected = true
        self.communityButton.isSelected = false
        self.dotImageView1.isHidden = false
        self.dotImageView2.isHidden = true

        
    }
    
    @IBAction func communityButtonDidTap(_ sender: Any) {
        self.communityButton.isSelected = true
        self.problemButton.isSelected = false
        self.dotImageView1.isHidden = true
        self.dotImageView2.isHidden = false

    }
}

class ProblemFilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filterTitle: UILabel!
    
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var popularButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        let selectedAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13, weight: .medium),
            .foregroundColor: UIColor.label
        ]
        let normalAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13, weight: .medium),
            .foregroundColor: UIColor.secondaryLabel
        ]
        self.popularButton.setAttributedTitle(NSAttributedString(string: "• 인기순", attributes: normalAttribute), for: .normal)
        
        self.popularButton.setAttributedTitle(NSAttributedString(string: "• 인기순", attributes: selectedAttribute), for: .selected)
        
        self.recentButton.setAttributedTitle(NSAttributedString(string: "• 최신순", attributes: normalAttribute), for: .normal)
        
        self.recentButton.setAttributedTitle(NSAttributedString(string: "• 최신순", attributes: selectedAttribute), for: .selected)
        self.popularButton.isSelected = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(totalCount: Int) {
        let attribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13, weight: .light),
            .foregroundColor: UIColor.label
        ]
        let title = "총 \(totalCount)개의 문제"
        let mutableAttributedString = NSMutableAttributedString(string: title, attributes: attribute)
        mutableAttributedString.addAttributes([
            .font: UIFont.systemFont(ofSize: 13, weight: .bold)
        ], range: (title as NSString).range(of: "\(totalCount)"))
        self.filterTitle.attributedText = mutableAttributedString
    }
    
    @IBAction func popularButtonDidTap(_ sender: Any) {
        self.popularButton.isSelected = true
        self.recentButton.isSelected = false
    }
    
    @IBAction func recentButtonDidTap(_ sender: Any) {
        self.recentButton.isSelected = true
        self.popularButton.isSelected = false
    }
    
}

class ProblemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scrapButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var problemTitleLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var problemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupViews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupViews() {
        self.problemImageView.layer.cornerRadius = 16
        self.levelLabel.backgroundColor = UIColor(hex: "#00dad2").withAlphaComponent(0.15)
        self.levelLabel.font = UIFont.systemFont(ofSize: 10, weight: .black)
        self.levelLabel.textColor = UIColor(hex: "#00dad2")
        
        self.problemTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        self.problemTitleLabel.textColor = UIColor.label
        
        self.dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        self.dateLabel.textColor = UIColor.secondaryLabel
    }
    
    func configure() {
        
    }
}
