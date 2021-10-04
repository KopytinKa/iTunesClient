//
//  SearchSongPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 28.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SearchSongPresenter: SearchSongViewOutput {
    
    weak var view: SearchSongViewInput!
    var router: SearchSongRouterInput!
    var interactor: SearchSongInteractorInput!
    
    
    func requestSongs(with query: String) {
        self.view.throbber(show: true)
        self.view.setSearchResultSongs([])
        
        self.interactor.searchSong(for: query)
    }
}

// MARK: - SearchSongInteractorOutput

extension SearchSongPresenter: SearchSongInteractorOutput {
    func receivedSongs(_ songs: [ITunesSong]) {
        self.view.throbber(show: false)
        self.view.setEmptyStateVisible(songs.isEmpty)
        self.view.setSearchResultSongs(songs)
    }
    
    func receivedError(_ error: Error) {
        self.view.throbber(show: false)
        self.view.setEmptyStateVisible(true)
        self.view.showError(error: error)
    }
}

// MARK: - SearchSongRouterOutput

extension SearchSongPresenter: SearchSongRouterOutput {
    
}
