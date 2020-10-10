import UIKit

class ProblemViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var placeholderStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var problemImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageTitleLabel: UILabel!
    var dimmedView: DimmedView!
    var currentPosition: CGPoint = .zero
    
    static func create() -> ProblemViewController  {
        let storyboard = UIStoryboard(name: "Gym", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ProblemViewController") as! ProblemViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupNavigation()
        self.setupTableView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupNavigation() {
        self.title = "문제 등록"
        self.updateNavigationBarAsDefault()
        self.setupLeftItemButton()
    
        let completeButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(completeButtonDidTap))
        self.navigationItem.rightBarButtonItem = completeButton
    }
    
    @objc
    func completeButtonDidTap() {
        guard let image = self.imageWithView(view: self.problemImageView) else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let uploadable = UploadableImageData(data: imageData, mimeType: "jpg")
        let url = "\(Key.apiHost)/upload"
        //ApiManager.shared.upload(url: url, uploadable: uploadable)
    }
    
    func imageWithView(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func setupViews() {
        self.titleLabel.text = "문제 제목"
        self.imageTitleLabel.text = "문제 사진"
        [self.titleLabel, self.imageTitleLabel].forEach {
            $0?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            $0?.textColor = .label
        }
        self.titleTextField.backgroundColor = .tertiarySystemFill
        self.problemImageView.backgroundColor = .tertiarySystemFill
        self.problemImageView.layer.cornerRadius = 18
        self.problemImageView.contentMode = .scaleAspectFill
        self.problemImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTap))
        self.problemImageView.addGestureRecognizer(tapGesture)
        
        let dimmedView = DimmedView()
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dimmedView.isUserInteractionEnabled = true
        let dimmedTapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmedViewDidTap))
        dimmedView.addGestureRecognizer(dimmedTapGesture)
        self.dimmedView = dimmedView
    }
    
    @objc
    func dimmedViewDidTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.currentPosition = .zero
            self.dimmedView.becomeFirstResponder()
            let touchLocation: CGPoint = sender.location(in: sender.view)
            self.currentPosition = touchLocation
            let startMenuItem = UIMenuItem(title: "시작", action: #selector(self.addStart))
            let pathMenuItem = UIMenuItem(title: "추가", action: #selector(self.addPath))
            let endMenuItem = UIMenuItem(title: "끝", action: #selector(self.addEnd))
            UIMenuController.shared.menuItems = [startMenuItem, pathMenuItem, endMenuItem]
            UIMenuController.shared.showMenu(from: self.dimmedView, rect: CGRect(x: touchLocation.x - 50, y: touchLocation.y, width: 100, height: 100))
        }
    }
    
    @objc
    func addStart() {
        let startCircle = CirecleView(frame: .zero, type: .start)
        self.dimmedView.addSubview(startCircle)
        startCircle.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 34, height: 34))
            $0.center.equalTo(self.currentPosition)
        }
    }
    
    @objc
    func addEnd() {
        let startCircle = CirecleView(frame: .zero, type: .end)
        self.dimmedView.addSubview(startCircle)
        startCircle.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 34, height: 34))
            $0.center.equalTo(self.currentPosition)
        }
    }
    
    @objc
    func addPath() {
        let startCircle = CirecleView(frame: .zero, type: .path)
        self.dimmedView.addSubview(startCircle)
        startCircle.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 20, height: 20))
            $0.center.equalTo(self.currentPosition)
        }
    }
    
    func setupTableView() {
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
    }
    
    @objc
    func imageViewDidTap() {
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else { return }
        self.problemImageView.image = image
        self.placeholderStackView.isHidden = true
        self.problemImageView.addSubview(self.dimmedView)
        self.dimmedView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}

class DimmedView: UIView {
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CirecleView: UIView {
    
    enum CircleType {
        case start
        case path
        case end
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, type: CircleType) {
        self.init(frame: frame)
        self.makeCircle(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCircle(type: CircleType) {
        let label = self.makeLabel(type: type)
        self.addSubview(label)
    }
    
    func makeLabel(type: CircleType) -> UILabel {
        let label = UILabel()
        switch type {
        case .start:
            label.text = "START"
            label.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        case .path:
            label.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        case .end:
            label.text = "END"
            label.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }
        label.font = UIFont.systemFont(ofSize: 8, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = label.frame.height / 2
        label.clipsToBounds = true
        label.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.white.cgColor
        return label
    }
}

class RemoveView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
