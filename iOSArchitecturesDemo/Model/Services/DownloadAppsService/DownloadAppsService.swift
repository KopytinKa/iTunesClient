//
//  DownloadAppsService.swift
//  iOSArchitecturesDemo
//
//  Created by Кирилл Копытин on 28.09.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

class DownloadingApp {
    
    enum DownloadState {
        case notStarted
        case progress(_ value: Double)
        case downloaded
    }
    
    let app: ITunesApp
    var state: DownloadState = .notStarted
    
    init(_ app: ITunesApp) {
        self.app = app
    }
}

protocol DownloadAppsServiceInput: AnyObject {
    var downloadingApps: [DownloadingApp] { get }
    var onProgressUpdate: (() -> Void)? { get set }
    func startDownloadApp(_ app: ITunesApp)
}

final class FakeDownloadAppsService: DownloadAppsServiceInput {
    private(set) var downloadingApps: [DownloadingApp] = []
    private var timers: [Timer] = []
    
    var onProgressUpdate: (() -> Void)?
    
    func startDownloadApp(_ app: ITunesApp) {
        if !self.downloadingApps.contains(where: { $0.app.appName == app.appName }) {
            let downloadingApp = DownloadingApp(app)
            self.startDownloading(for: downloadingApp)
            
            self.downloadingApps.append(downloadingApp)
        }
    }
    
    //MARK: - Private
    
    private func startDownloading(for app: DownloadingApp) {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [unowned self] timer in
            switch app.state {
            case .notStarted:
                app.state = .progress(0.05)
            case .progress(let value):
                let newValue = value + 0.05
                if newValue >= 1 {
                    app.state = .downloaded
                    self.invalidateTimer(timer)
                } else {
                    app.state = .progress(newValue)
                }
            case .downloaded:
                self.invalidateTimer(timer)
            }
            
            self.onProgressUpdate?()
        }
        
        RunLoop.main.add(timer, forMode: .common)
        self.timers.append(timer)
    }
    
    private func invalidateTimer(_ timer: Timer) {
        timer.invalidate()
        self.timers.removeAll(where: { $0 === timer })
    }
}
