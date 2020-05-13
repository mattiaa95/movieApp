//
//  AppDelegate.swift
//  movieApp
//
//  Created by Mattia La Spina on 5/11/20.
//  Copyright © 2020 Mattia La Spina. All rights reserved.
//

import UIKit
import Moya

var clientApi = MoyaProvider<Client>()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
     
    }
    
    func applicationWillTerminate(_ application: UIApplication) {

    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
    }
    
}
