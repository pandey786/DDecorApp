//
//  AppDelegate.swift
//  DDecorApp
//
//  Created by Durgesh Pandey on 12/04/18.
//  Copyright © 2018 DDecor. All rights reserved.
//

import UIKit
import GoogleSignIn
import IQKeyboardManagerSwift
import RESideMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var sideMenuViewController: RESideMenu?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Load Splash as Root Controller
        self.loadSplashScreen()
        
        //Set Up keyBoard Manager
        IQKeyboardManager.sharedManager().enable = true
        
        UINavigationBar.appearance().barTintColor = UIColor.darkGray
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        //Set Status Bar Style
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "602111596084-htqi3k3729rob8jrcgo77j7mog5sbk0o.apps.googleusercontent.com"
        
        return true
    }
    
    func loadSplashScreen() {
        
        //Load Splash Screen
        let splashViewController: SplashViewController = StoryBoard.main.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
    }
    
    func loadLoginScreen() {
        
        //Load Login Screen
        let loginViewController: LoginViewController = StoryBoard.main.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        window?.rootViewController = UINavigationController.init(rootViewController: loginViewController)
        window?.makeKeyAndVisible()
    }
    
    func loadDashboardScreen() {
        
        //Load Dashboard Screen
        let dashBoardNavCtrl: UINavigationController = StoryBoard.main.instantiateViewController(withIdentifier: "DashboardNavViewController") as! UINavigationController
        
        let menuViewController: SideMenuViewController = StoryBoard.main.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        
        if let sideMenu = RESideMenu.init(contentViewController: dashBoardNavCtrl, leftMenuViewController: menuViewController, rightMenuViewController: menuViewController) {
            
            sideMenu.panGestureEnabled = false
            sideMenu.backgroundImage = UIImage.init(named: "background")
            
            window?.setRootViewController(sideMenu, options: UIWindow.TransitionOptions.init(direction: .fade, style: .easeInOut))
            window?.makeKeyAndVisible()
            
            self.sideMenuViewController = sideMenu
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
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

