//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    public var app: ITunesApp!
    
    lazy var headerViewController = AppDetailHeaderViewController(app: app)
    
    private var appDetailView: AppDetailView {
        return self.view as! AppDetailView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = AppDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    // MARK: - Private
    
    private func setupViews() {
        self.configureNavigationController()
        self.addHeaderViewController()
    }
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addHeaderViewController() {
        self.addChild(self.headerViewController)
        
        self.view.addSubview(self.headerViewController.view)
        self.headerViewController.didMove(toParent: self)
        
        self.headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
    }
}
