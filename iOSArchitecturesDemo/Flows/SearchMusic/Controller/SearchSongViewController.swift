//
//  SearchSongViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 28.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class SearchSongViewController: UIViewController, SearchSongViewInput {
    
    // MARK: - Private Properties
    
    private var searchView: SearchSongView {
        return self.view as! SearchSongView
    }
    
    private var searchResults = [ITunesSong]()
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    var output: SearchSongViewOutput!
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchSongView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(SongCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
    
    // MARK: - SearchViewInput
    
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setEmptyStateVisible(_ isVisible: Bool) {
        self.searchView.emptyResultView.isHidden = !isVisible
    }
    
    func setSearchResultSongs(_ songs: [ITunesSong]) {
        self.searchResults = songs
        self.searchView.tableView.isHidden = false
        self.searchView.tableView.reloadData()
        
        self.searchView.searchBar.resignFirstResponder()
    }
}

//MARK: - UITableViewDataSource
extension SearchSongViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? SongCell else {
            return dequeuedCell
        }
        let song = self.searchResults[indexPath.row]
        let cellModel = SongCellModelFactory.cellModel(from: song)
        cell.configure(with: cellModel)
        return cell
    }
}

//MARK: - UISearchBarDelegate
extension SearchSongViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        
        self.output.requestSongs(with: query)
    }
}

