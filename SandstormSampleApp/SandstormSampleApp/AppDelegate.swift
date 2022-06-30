//
//  AppDelegate.swift
//  SandstormSampleApp
//
//  Created by Mateusz Wojnar on 21/04/2022.
//
import UIKit
import SandstormSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //Initialize with launchOptions
        ATSandstormSDK.shared.initialize(with: launchOptions)
        //Sets NumberEight key before start method (skip this step on SandstormLiteSDK)
        ATSandstormSDK.shared.setNumberEightKey("U71E94V86CT9ZXY98ABNMFLQ0Y9B")

        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
