
import UIKit
import Combine

class SearchFavoriteGymViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var cancellable = Set<AnyCancellable>()
    
    var gyms: [Gym] = []
    var selectedGym: [Gym] = []
    
    var keyboardFrame: CGRect = .zero
    var completion: (([Gym]) -> Void)?
    
    static func create(completion: @escaping (([Gym]) -> Void)) -> SearchFavoriteGymViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SearchFavoriteGymViewController") as! SearchFavoriteGymViewController
        viewController.completion = completion
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        self.setupSearchBar()
        self.setupCollectionView()
        self.setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupNavigation() {
        self.title = "자주가는 암장 등록하기"
        self.setupLeftItemButton()
        let rightCheckButton = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(checkButtonDidTap))
        self.navigationItem.rightBarButtonItem = rightCheckButton
        self.updateCheckButton()
    }
    
    @objc
    func checkButtonDidTap() {
        self.completion?(self.selectedGym)
        self.dismiss(animated: true)
    }
    
    func updateCheckButton() {
        let enable = self.selectedGym.isEmpty == false
        let checkButton = self.navigationItem.rightBarButtonItem
        checkButton?.tintColor = enable ? UIColor.black : UIColor.systemGray
        checkButton?.isEnabled = enable
    }
    
    func setupSearchBar() {
        self.searchBar.placeholder = "검색하기"
        self.searchBar.delegate = self
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionViewHeight.constant = 0
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
    
    func updateCollectionViewHeight() {
        if self.selectedGym.isEmpty {
            self.collectionViewHeight.constant = 0
        } else {
            self.collectionViewHeight.constant = 50
        }
    }
}

extension SearchFavoriteGymViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gyms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFavoriteGymTableViewCell", for: indexPath) as! SearchFavoriteGymTableViewCell
        cell.configure(gym: self.gyms[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isDuplicate = selectedGym.contains { $0.id == self.gyms[indexPath.row].id }
        if isDuplicate { return }
        self.selectedGym.append(self.gyms[indexPath.row])
        self.collectionView.reloadData()
        self.updateCollectionViewHeight()
        self.updateCheckButton()
    }
}

class SearchFavoriteGymTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gymNameLabel: UILabel!
    
    @IBOutlet weak var gymAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(gym: Gym) {
        self.gymNameLabel.text = gym.name
        self.gymAddressLabel.text = gym.address
    }
}

extension SearchFavoriteGymViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedGym.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedFavoriteGymCollectionViewCell", for: indexPath) as! SelectedFavoriteGymCollectionViewCell
        cell.configure(gym: self.selectedGym[indexPath.item])
        return cell
    }
}

class SelectedFavoriteGymCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedGymButton: UIButton!
    
    override func awakeFromNib() {
        // 클라이밍
        super.awakeFromNib()
        self.selectedGymButton.layer.borderWidth = 0.5
        self.selectedGymButton.layer.cornerRadius = 10
        self.selectedGymButton.layer.borderColor = UIColor(hex: "#eeeeee").cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(gym: Gym) {
        self.selectedGymButton.setTitle(gym.name, for: .normal)
        self.selectedGymButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
