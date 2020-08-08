
import UIKit

class ProblemViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, FadeNavigationPresentable {
    
    var titleView: FadeTitleButton!
    
    enum Section: Int, CaseIterable {
        case title
        case bigCategory
        case filter
        case problem
    }
    
    @IBOutlet weak var tableView: UITableView!
    var arr: [String] = ["zedd","zedd","zedd","zedd","zedd","zedd","zedd"]
    
    static func create() -> ProblemViewController {
        let storyboard = UIStoryboard(name: "Problem", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ProblemViewController") as! ProblemViewController
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
            return UITableViewCell()
        case .filter:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProblemFilterTableViewCell", for: indexPath) as!  ProblemFilterTableViewCell
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateTitle(scrollView)
    }
}

class ProblemTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(currentGymTitle: String) {
        let attribute: [NSAttributedString.Key: Any] =
            [
                .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                .foregroundColor: UIColor.label
            ]
        self.titleButton.setAttributedTitle(NSAttributedString(string: currentGymTitle, attributes: attribute), for: .normal)
    }
    
    @IBAction func changeGymButtonDidTap(_ sender: Any) {
        
    }
}

class ProblemFilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filterTitle: UILabel!
    
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var popularButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

class ProblemTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure() {
        
    }
}
