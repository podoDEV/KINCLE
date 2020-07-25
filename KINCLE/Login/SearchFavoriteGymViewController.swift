//
//  SearchFavoriteGymViewController.swift
//  KINCLE
//
//  Created by Zedd on 2020/06/27.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit

class SearchFavoriteGymViewController: BaseViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //var searchResults = [MKLocalSearchCompletion]()
    
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
    }
    
    func setupNavigation() {
        self.title = "자주가는 암장 등록하기"
        self.setupLeftItemButton()
    }
    
    func setupSearchBar() {
        self.searchBar.placeholder = "검색하기"
        //self.searchBar.delegate = self

    }
    
    func setupTableView() {
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
    }
}

//extension SearchFavoriteGymViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.searchResults.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.text = self.searchResults[indexPath.row].title
//        return cell
//    }
//}

