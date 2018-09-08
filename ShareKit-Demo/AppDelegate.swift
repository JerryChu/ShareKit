//
//  AppDelegate.swift
//  ShareKit-Demo
//
//  Created by JerryChu on 2018/9/2.
//  Copyright © 2018 JerryChu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TencentSessionDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // 使用官方demo提供的appid
        let _ = TencentOAuth(appId: "222222", andDelegate: self)
        WXApi.registerApp("wxd930ea5d5a258f4f", enableMTA: false)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        QQApiInterface.handleOpen(url, delegate: nil)

        if (TencentOAuth.canHandleOpen(url)) {
            return TencentOAuth.handleOpen(url)
        }
        return WXApi.handleOpen(url, delegate: nil)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - TencentSessionDelegate
    func tencentDidLogin() {
        print("tencentDidLogin")
    }
    
    func tencentDidNotLogin(_ cancelled: Bool) {
        print("tencentDidNotLogin")
    }
    
    func tencentDidNotNetWork() {
        print("tencentDidNotNetWork")
    }
    
}

