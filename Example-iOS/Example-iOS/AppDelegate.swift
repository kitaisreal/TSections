//
//  AppDelegate.swift
//  Example-iOS
//
//  Created by Kita, Maksim on 1/9/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = SectionsViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}

