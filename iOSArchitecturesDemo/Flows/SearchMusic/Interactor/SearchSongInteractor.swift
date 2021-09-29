//
//  SearchSongInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 29.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

class SearchSongInteractor: SearchSongInteractorInput {
    
    weak var output: SearchSongInteractorOutput!
    
    private let searchService: ITunesSearchService
    
    init(searchService: ITunesSearchService) {
        self.searchService = searchService
    }
    
    func searchSong(for query: String) {
        self.searchService.getSongs(forQuery: query) { [unowned self] result in
            result
                .withValue { songs in
                    self.output.receivedSongs(songs)
                }.withError { error in
                    self.output.receivedError(error)
                }
        }
    }
}
