//
//  SearchSongAssembly.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 28.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

enum SearchSongAssembly {
    static func build() -> SearchSongViewController {
        let presenter = SearchSongPresenter()
        let viewController = SearchSongViewController()
        
        // bindings
        viewController.output = presenter
        presenter.view = viewController
        
        return viewController
    }
}
