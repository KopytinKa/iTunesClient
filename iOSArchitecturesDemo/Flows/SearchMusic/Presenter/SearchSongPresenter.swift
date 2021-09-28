//
//  SearchSongPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 28.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SearchSongPresenter: SearchSongViewOutput {
    
    weak var view: (SearchSongViewInput & UIViewController)!
    
    private let searchService = ITunesSearchService()
    
    func requestSongs(with query: String) {
        self.view.throbber(show: true)
        self.view.setSearchResultSongs([])
        
        self.searchService.getSongs(forQuery: query) { [unowned self] result in
            self.view.throbber(show: false)
            
            result
                .withValue { songs in
                    self.view.setEmptyStateVisible(songs.isEmpty)
                    self.view.setSearchResultSongs(songs)
                }.withError { error in
                    self.view.showError(error: error)
                }
        }
    }
}
