//
//  AppDelegate.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize Window
        window = UIWindow(frame: UIScreen.main.bounds)

        // Configure Window
        window?.rootViewController = appCoordinator.rootViewController

        // Make Key and Visible
        window?.makeKeyAndVisible()

        // Url caching
        let urlCache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        URLCache.shared = urlCache

        appCoordinator.start()
        return true
    }
}

