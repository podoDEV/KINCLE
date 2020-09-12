
import UIKit
import Combine

class SearchFavoriteGymViewController: BaseViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var cancellable = Set<AnyCancellable>()
    
    var gyms: [Gym] = []
    var keyboardFrame: CGRect = .zero
    
    static func create() -> SearchFavoriteGymViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SearchFavoriteGymViewController") as! SearchFavoriteGymViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        self.setupSearchBar()
        self.setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupNavigation() {
        self.title = "자주가는 암장 등록하기"
        self.setupLeftItemButton()
    }
    
    func setupSearchBar() {
        self.searchBar.placeholder = "검색하기"
        self.searchBar.delegate = self
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        ApiManager.shared.searchGym(query: query)
            .receive(on: DispatchQueue.main)
            .sink { (response) in
            self.gyms = response.gyms
            self.tableView.reloadData()
        }.store(in: &self.cancellable)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            self.keyboardFrame = keyboardFrame
        }
        let rate = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: rate ?? 0.25, animations: {
            self.tableView.contentInset.bottom = self.keyboardFrame.height
            self.view.layoutIfNeeded()
        })
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.25, animations: {
            self.tableView.contentInset.bottom = 0
            self.view.layoutIfNeeded()
        })
    }
}

extension SearchFavoriteGymViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gyms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.gyms[indexPath.row].name
        return cell
    }
}

