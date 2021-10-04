//
//  SearchSongViewIO.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 28.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchSongViewInput: AnyObject {
    func throbber(show: Bool)
    func showError(error: Error)
    func setEmptyStateVisible(_ isVisible: Bool)
    func setSearchResultSongs(_ songs: [ITunesSong])
}

protocol SearchSongViewOutput: AnyObject {
    func requestSongs(with query: String)
}
