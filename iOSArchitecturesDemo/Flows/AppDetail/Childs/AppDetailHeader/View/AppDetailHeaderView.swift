//
//  AppDetailHeaderView.swift
//  iOSArchitecturesDemo
//
//  Created by v.prusakov on 9/17/21.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit
import SwiftUI

class AppDetailHeaderView: UIView {
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var openButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Открыть", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        return button
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.openButton.layer.cornerRadius = self.openButton.bounds.height / 2
    }
    
    // MARK: - Private
    
    private func setupView() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        self.addSubview(self.openButton)
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.imageView.widthAnchor.constraint(equalToConstant: 120),
            self.imageView.heightAnchor.constraint(equalToConstant: 120),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.titleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 12),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 6),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 12),
            self.subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            self.openButton.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 12),
            self.openButton.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 12),
            self.openButton.widthAnchor.constraint(equalToConstant: 100),
            self.openButton.heightAnchor.constraint(equalToConstant: 36),
            self.openButton.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16)
        ])
    }
}

#if DEBUG

struct AppDetailHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        let view = AppDetailHeaderView()
        view.imageView.backgroundColor = .red
        view.titleLabel.text = "Vewjonfpqjiwe fqwieufb pqw;e fpquwef qpiewjf"
        view.titleLabel.backgroundColor = .red
        view.subtitleLabel.text = "Mail.ru Group"
        view.subtitleLabel.backgroundColor = .green

        return UIPreviewView(view)
            .previewLayout(.fixed(width: 375, height: 170))
    }
}

#endif
