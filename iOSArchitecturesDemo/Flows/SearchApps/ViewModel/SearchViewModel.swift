//
//  SearchViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 28.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SearchViewModel {
    
    let displayItems = Observable<[AppCellModel]>([])
    let isLoading = Observable<Bool>(false)
    let error = Observable<Error?>(nil)
    let showEmptyResult = Observable<Bool>(false)
    
    weak var viewController: UIViewController?
    
    private var apps: [ITunesApp] = []
    
    private let downloadingAppsService: DownloadAppsServiceInput
    private let searchService: ITunesSearchService
    
    init(downloadingAppsService: DownloadAppsServiceInput, searchService: ITunesSearchService) {
        self.downloadingAppsService = downloadingAppsService
        self.searchService = searchService
        
        downloadingAppsService.onProgressUpdate = { [unowned self] in
            self.displayItems.value = self.makeViewModels()
        }
    }
    
    // MARK: - Methods
    
    func search(for query: String) {
        self.isLoading.value = true
        
        self.searchService.getApps(forQuery: query) { [unowned self] result in
            self.isLoading.value = false
            
            result
                .withValue { apps in
                    self.apps = apps
                    self.displayItems.value = self.makeViewModels()
                    self.showEmptyResult.value = apps.isEmpty
                }
                .withError { error in
                    self.displayItems.value = []
                    self.showEmptyResult.value = true
                }
        }
    }
    
    func selectApp(_ viewModel: AppCellModel) {
        guard let app = self.app(for: viewModel) else { return }
        let viewController = AppDetailViewController()
        viewController.app = app
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func downloadApp(for viewModel: AppCellModel) {
        guard let app = self.app(for: viewModel) else { return }
        self.downloadingAppsService.startDownloadApp(app)
    }
    
    // MARK: - Private]
    
    private func makeViewModels() -> [AppCellModel] {
        return self.apps.map { app in
            let downloadingApp = self.downloadingAppsService.downloadingApps.first {
                $0.app.appName == app.appName
            }
            
            return AppCellModelFactory.cellModel(
                from: app,
                downloadState: downloadingApp?.state ?? .notStarted
            )
        }
    }
    
    private func app(for viewModel: AppCellModel) -> ITunesApp? {
        return self.apps.first(where: { $0.appName == viewModel.title })
    }
}
