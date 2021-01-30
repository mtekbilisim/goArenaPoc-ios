//
//  AppDelegate.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var reachability: Reachability?
    let networkManager = NetworkManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppAppearance.setupAppearance()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        window?.rootViewController = UINavigationController(rootViewController: SplashViewController(networkManager: networkManager))
        
        setReachability()
        return true
    }
    
    func setReachability(){
        
        self.reachability = try! Reachability()
        do {
            try reachability?.startNotifier()
        } catch {
            print( "ERROR: Could not start reachability notifier." )
        }
    }

    class func sharedAppDelegate() -> AppDelegate?{
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func openApp() {
        let loggedIn:Bool = true
        window?.rootViewController = ArenaTabbarController()
        
//        if User.loggedIn() {
//            window?.rootViewController = ArenaTabbarController()
//        } else {
//          window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
//        }
    }
    
    
}

