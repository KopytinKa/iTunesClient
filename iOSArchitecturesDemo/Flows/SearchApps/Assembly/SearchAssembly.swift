//
//  SearchAssembly.swift
//  iOSArchitecturesDemo
//
//  Created by v.prusakov on 9/17/21.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

enum SearchAssembly {
    static func build() -> SearchViewController {
        let viewController = SearchViewController()
        
        let viewModel = SearchViewModel(
            downloadingAppsService: FakeDownloadAppsService(),
            searchService: ITunesSearchService()
        )
        
        // bindings
        viewController.viewModel = viewModel
        viewModel.viewController = viewController
        
        return viewController
    }
}
