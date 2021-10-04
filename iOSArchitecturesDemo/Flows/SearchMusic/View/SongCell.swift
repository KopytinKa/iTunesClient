//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 27.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class SongCell: UITableViewCell {
            
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    private(set) lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    private(set) lazy var artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    private let imageDownloader = ImageDownloader()
    
    func configure(with cellModel: SongCellModel) {
        self.titleLabel.text = cellModel.title
        self.subtitleLabel.text = cellModel.subtitle
        self.collectionLabel.text = cellModel.collection
        self.downloadImageForUrl(cellModel.artwork)
    }
    
    private func downloadImageForUrl(_ url: String?) {
        guard let url = url else { return }
        self.imageDownloader.getImage(fromUrl: url) { [weak self] image, error in
            self?.artworkImageView.image = image
        }
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.titleLabel, self.subtitleLabel, self.collectionLabel].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addArtworkImageView()
        self.addTitleLabel()
        self.addSubtitleLabel()
        self.addCollectionLabel()
    }
    
    private func addTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.artworkImageView.rightAnchor, constant: 12.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addSubtitleLabel() {
        self.contentView.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4.0),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.artworkImageView.rightAnchor, constant: 12.0),
            self.subtitleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addCollectionLabel() {
        self.contentView.addSubview(self.collectionLabel)
        NSLayoutConstraint.activate([
            self.collectionLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 4.0),
            self.collectionLabel.leftAnchor.constraint(equalTo: self.artworkImageView.rightAnchor, constant: 12.0),
            self.collectionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addArtworkImageView() {
        self.contentView.addSubview(self.artworkImageView)
        NSLayoutConstraint.activate([
            self.artworkImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.artworkImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.artworkImageView.widthAnchor.constraint(equalToConstant: 40),
            self.artworkImageView.heightAnchor.constraint(equalToConstant: 40),
            ])
    }
}

