
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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
            return cell
        case .info:
            
        case .personalTerms:
            <#code#>
        case .feedback:
            <#code#>
        case .logout:
            <#code#>
        }
    }
}
