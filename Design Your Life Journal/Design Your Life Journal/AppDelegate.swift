//  AppDelegate.swift
//  Design Your Life Journal
//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Appearance.setAppearance()
        return true
    }
}

