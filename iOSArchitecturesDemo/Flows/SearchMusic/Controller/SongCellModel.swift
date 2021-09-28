//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 27.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

struct SongCellModel {
    let title: String
    let subtitle: String?
    let collection: String?
    let artwork: String?
}

final class SongCellModelFactory {
        
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(title: model.trackName,
                             subtitle: model.artistName,
                             collection: model.collectionName,
                             artwork: model.artwork)
    }
}
