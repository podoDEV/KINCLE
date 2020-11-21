
import UIKit

class SettingsViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case space1
        case info
        case personalTerms
        case feedback
        case space2
        case logout
    }
    
    static func create() -> SettingsViewController {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        return viewController
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(SettingsImageTitleTableViewCell.self, forCellReuseIdentifier: "SettingsImageTitleTableViewCell")
        self.tableView.tableFooterView = UIView()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)!
        switch section {
        case .space1, .space2:
            let cell = UITableViewCell()
            cell.backgroundColor = UIColor(hex: "#dbdbdb")
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsImageTitleTableViewCell", for: indexPath) as! SettingsImageTitleTableViewCell
            cell.configure(configration: SettinsCellConfiguration(image: UIImage(systemName: "info.circle"), title: "정보", subtitle: nil))
            return cell
        case .personalTerms:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsImageTitleTableViewCell", for: indexPath) as! SettingsImageTitleTableViewCell
            cell.configure(configration: SettinsCellConfiguration(image: UIImage(systemName: "rectangle.stack.person.crop"), title: "개인정보 처리 방침", subtitle: nil))
            return cell
        case .feedback:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsImageTitleTableViewCell", for: indexPath) as! SettingsImageTitleTableViewCell
            cell.configure(configration: SettinsCellConfiguration(image: UIImage(systemName: "paperplane"), title: "피드백 보내기", subtitle: nil))
            return cell
        case .logout:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsImageTitleTableViewCell", for: indexPath) as! SettingsImageTitleTableViewCell
            cell.configure(configration: SettinsCellConfiguration(image: UIImage(systemName: "person.badge.minus"), title: "로그아웃", subtitle: nil))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Section(rawValue: indexPath.section)! {
        case .space1, .space2:
            return 10
        default:
            return 50
        }
    }
}
