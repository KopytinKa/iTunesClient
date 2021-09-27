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
        let presenter = SearchPresenter()
        let viewController = SearchViewController()
        
        // bindings
        viewController.output = presenter
        presenter.view = viewController
        
        return viewController
    }
}
