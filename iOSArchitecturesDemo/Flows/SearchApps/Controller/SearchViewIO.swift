//
//  SearchViewIO.swift
//  iOSArchitecturesDemo
//
//  Created by v.prusakov on 9/17/21.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewInput: AnyObject {
    func throbber(show: Bool)
    func showError(error: Error)
    func setEmptyStateVisible(_ isVisible: Bool)
    func setSearchResultApps(_ apps: [ITunesApp])
}

protocol SearchViewOutput: AnyObject {
    func requestApps(with query: String)
    func openAppDetails(with app: ITunesApp)
}
