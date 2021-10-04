//
//  SearchSongInteractorIO.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 29.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

protocol SearchSongInteractorInput: AnyObject {
    func searchSong(for query: String)
}

protocol SearchSongInteractorOutput: AnyObject {
    func receivedSongs(_ songs: [ITunesSong])
    func receivedError(_ error: Error)
}
