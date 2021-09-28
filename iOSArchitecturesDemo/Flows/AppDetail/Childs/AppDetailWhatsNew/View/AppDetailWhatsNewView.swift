//
//  AppDetailWhatsNewView.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 27.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit
import SwiftUI

class AppDetailWhatsNewView: UIView {
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Что нового"
        return label
    }()
    
    private(set) lazy var versionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        label.text = "Версия "
        return label
    }()
    
    private(set) lazy var versionDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var versionNotesLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 5
        return label
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
    }
    
    // MARK: - Private
    
    private func setupView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.versionLabel)
        self.addSubview(self.versionDateLabel)
        self.addSubview(self.versionNotesLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            self.versionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.versionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            self.versionDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.versionDateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            
            self.versionNotesLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.versionNotesLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.versionNotesLabel.topAnchor.constraint(equalTo: self.versionLabel.bottomAnchor, constant: 16),
            self.versionNotesLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16)
        ])
    }
}


#if DEBUG

struct AppDetailWhatsNewView_Preview: PreviewProvider {
    static var previews: some View {
        let view = AppDetailWhatsNewView()
        view.titleLabel.text = "Что нового"
        view.versionLabel.text = "Версия 5.4"
        view.versionDateLabel.text = "1 год назад"
        view.versionNotesLabel.text = "asfa sdf sdfsd fsd fsd fsdf sdfsd fsd fsdf sdfds fsd f  sdfdsfsdfsdfs sdfdsf sdfsdf  sdfsdfdsf  sdfdsfdsfdsf  sdfsdf sdfdsfsdfsdfs sdfdsf sdfsdf  sdfsdfdsf  sdfdsfdsfdsf  sdfsdf sdfdsfsdfsdfs sdfdsf sdfsdf  sdfsdfdsf  sdfdsfdsfdsf  sdfsdf sdfdsfsdfsdfs sdfdsf sdfsdf  sdfsdfdsf  sdfdsfdsfdsf  sdfsdf sdfdsfsdfsdfs sdfdsf sdfsdf  sdfsdfdsf  sdfdsfdsfdsf  sdfsdf"

        return UIPreviewView(view)
            .previewLayout(.fixed(width: 375, height: 200))
    }
}

#endif
