//
//  AppDelegate.swift
//  FontAndEmojiCollection
//
//  Created by Zenny Chen on 2017/3/14.
//  Copyright © 2017年 CodeLearning Studio. All rights reserved.
//

import UIKit

func getLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, tableName: "InfoPlist", comment: "")
}

class Utilities {
    
    let screenSize: CGSize
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    let screenScale: CGSize
    let fontScale: CGFloat
    
    static let instance = Utilities()
    
    private init() {
        screenSize = UIScreen.main.bounds.size
        
        if isPhone {
            // iPhone以320x568分辨率为基准
            screenScale = CGSize(width: screenSize.width / 320.0, height: screenSize.height / 568.0)
            fontScale = 1.0
        }
        else {
            // iPad以768x1024分辨率作为基准
            screenScale = CGSize(width: (screenSize.width / 768.0) * (768.0 / 320.0), height: (screenSize.height / 1024.0) * (1024.0 / 568.0))
            fontScale = 2.1
        }
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let str = getLocalizedString("HELLO_WORLD")
        print("str = \(str)")
        
        return true
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
}

