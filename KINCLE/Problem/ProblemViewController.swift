
import UIKit

class ProblemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var arr: [String] = ["zedd"]
    
    static func create() -> ProblemViewController {
        let storyboard = UIStoryboard(name: "Problem", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ProblemViewController") as! ProblemViewController
        return viewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
