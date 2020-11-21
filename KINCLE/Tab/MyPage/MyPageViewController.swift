
import UIKit
import Combine

import Kingfisher

class MyPageViewController: BaseViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var favoriteGymTitleLabel: UILabel!
    
    @IBOutlet weak var favoritGymLabel1: UILabel!
    @IBOutlet weak var favoriteGymLabel2: UILabel!
    @IBOutlet weak var favoriteGymLabel3: UILabel!
    
    var viewModel: MyPageViewModel = MyPageViewModel()
    
    var cancellable =  Set<AnyCancellable>()

    enum Section: Int, CaseIterable {
        case space1
        case problemsMadeByMe
        case solvedProblems
        case savedProblems
        case space2
        case settings
        case bottomPadding
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    static func create() -> MyPageViewController {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MyPageViewController") as! MyPageViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.title = "마이 페이지"
        self.view.backgroundColor = .white
        let edit = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(editButtonDidTap))
        self.navigationItem.rightBarButtonItem = edit
        
        self.observeModel()
    }
    
    func observeModel() {
        self.viewModel.userStream.sink {
            self.updateView()
            self.tableView.reloadData()
        }.store(in: &self.cancellable)
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorInset = .zero
    }
    
    @objc
    func editButtonDidTap() {
        
    }
    
    func updateView() {
        if let profileImageUrl = self.viewModel.user.profileImageUrl, let url = URL(string: profileImageUrl) {
            self.profileImageView.kf.setImage(with: url)
        }
        
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            self.updateNavigationBarAsDefault()
        } else {
            self.updateNavigationBarAsTransparent()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let section = Section(rawValue: indexPath.section)!
        switch section {
        case .space1, .space2:
            let cell = UITableViewCell()
            return cell
        case .problemsMadeByMe:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsImageTitleTableViewCell", for: indexPath) as! SettingsImageTitleTableViewCell
            cell.configure(configration: SettinsCellConfiguration(image: UIImage(systemName: "plus"), title: "내가 등록한 문제 보기", subtitle: "0"))
            return cell
        case .solvedProblems:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsImageTitleTableViewCell", for: indexPath) as! SettingsImageTitleTableViewCell
            cell.configure(configration: SettinsCellConfiguration(image: UIImage(systemName: "checkmark"), title: "내가 푼 문제 보기", subtitle: "0"))
            return cell
        case .savedProblems:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsImageTitleTableViewCell", for: indexPath) as! SettingsImageTitleTableViewCell
            cell.configure(configration: SettinsCellConfiguration(image: UIImage(systemName: "bookmark"), title: "저장한 문제 보기", subtitle: "0"))
            return cell
        case .bottomPadding:
            let cell = UITableViewCell()
            return cell
        case .settings:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsImageTitleTableViewCell", for: indexPath) as! SettingsImageTitleTableViewCell
            cell.configure(configration: SettinsCellConfiguration(image: UIImage(systemName: "gearshape"), title: "환경설정", subtitle: nil))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = Section(rawValue: indexPath.section)!
        switch section {
        case .problemsMadeByMe, .savedProblems, .solvedProblems, .settings:
            return 50
        case .space1, .space2:
            return 10
        case .bottomPadding:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = Section(rawValue: indexPath.section)!
        switch section {
        case .space1, .space2, .bottomPadding:
            return
        case .problemsMadeByMe:
            return
        case .solvedProblems:
            return
        case .savedProblems:
            return
        case .settings:
            let viewController = SettingsViewController.create()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

struct SettinsCellConfiguration {
    var image: UIImage?
    var title: String
    var subtitle: String?
}

class SettingsImageTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
