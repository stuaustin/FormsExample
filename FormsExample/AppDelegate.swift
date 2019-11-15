//
//  AppDelegate.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()

        let rootCoordinator = RootCoordinator(navigationController: navigationController)
        rootCoordinator.start()
        self.rootCoordinator = rootCoordinator

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}

