//
//  AppStartConfigurator.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppStartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let rootVC = SearchAssembly.build()
        rootVC.navigationItem.title = "Search via iTunes"
        rootVC.tabBarItem.image = UIImage(systemName: "gamecontroller")
        rootVC.tabBarItem.title = "Apps"
        
        let navVC = configuredNavigationController(rootViewController: rootVC)
        
        let secondVC = SearchSongAssembly.build()
        secondVC.navigationItem.title = "Search Song via iTunes"
        secondVC.tabBarItem.image = UIImage(systemName: "music.note")
        secondVC.tabBarItem.title = "Songs"
        
        let navSecondVC = configuredNavigationController(rootViewController: secondVC)
        
        let tabBarVC = self.configuredTabBarController
        tabBarVC.viewControllers = [navVC, navSecondVC]
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
    
    private func configuredNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }
    
    private lazy var configuredTabBarController: UITabBarController = {
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.barTintColor = UIColor.varna
        tabBarVC.tabBar.isTranslucent = false
        return tabBarVC
    }()
}
