//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    var viewModel: SearchViewModel!
    
    var displayItems: [AppCellModel] = []

    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
        
        self.setupBindings()
    }
    
    // MARK: - Private
    
    private func setupBindings() {
        self.viewModel.isLoading.addObserver(self) { isLoading, _ in
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        }
        
        self.viewModel.error.addObserver(self) { [weak self] error, _ in
            guard let error = error else { return }
            self?.showError(error)
        }
        
        self.viewModel.showEmptyResult.addObserver(self) { [weak self] isVisible, _ in
            self?.searchView.emptyResultView.isHidden = !isVisible
        }
        
        self.viewModel.displayItems.addObserver(self) { [weak self] items, _ in
            self?.displayItems = items
            self?.searchView.tableView.isHidden = items.isEmpty
            self?.searchView.tableView.reloadData()
            
            self?.searchView.searchBar.resignFirstResponder()
        }
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setEmptyStateVisible(_ isVisible: Bool) {
        self.searchView.emptyResultView.isHidden = !isVisible
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? AppCell else {
            return dequeuedCell
        }
        let item = self.displayItems[indexPath.row]
        cell.configure(with: item)
        
        cell.onDownloadButtonPressed = { [unowned self] cell in
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let item = self.displayItems[indexPath.row]
            self.viewModel.downloadApp(for: item)
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.displayItems[indexPath.row]
        self.viewModel.selectApp(item)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        
        self.viewModel.search(for: query)
    }
}
