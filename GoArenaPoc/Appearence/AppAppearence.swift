//
//  AppAppearence.swift
//  Kids Vid
//
//  Created by Adem Özsayın on 24.09.2020.
//

import Foundation
import UIKit

let screenRect = UIScreen.main.bounds
let screenWidth = screenRect.size.width
let screenHeight = screenRect.size.height
let padding:CGFloat = 16
let contentWidth:CGFloat = screenWidth - 2*padding
final class AppAppearance {
    
    static let background = UIColor.init(hex: "52B84D")
    static let appColor = UIColor.init(hex: "383363")
    //static let appColor = UIColor(red: CGFloat(88.0/255.0), green: CGFloat(86.0/255.0), blue: CGFloat(214.0/255.0), alpha: CGFloat(1.0))
    static let defaultFont = UIFont(name: "Montserrat-Regular", size: 13)
    static let defaultSemiFont = UIFont(name: "Montserrat-Medium", size: 10)
    
    static let defaultHeaderFont = UIFont(name: "Montserrat-Medium", size: 18)
    static let cellTitle = UIFont(name: "Montserrat-Regular", size: 16)
    static let pageTitle = UIFont(name: "Montserrat-Bold", size: 15)

    static let regularFont = "Montserrat-Regular"
    static let boldFont    = "Montserrat-Bold"
    static let navBarFont  = UIFont(name: "Montserrat-Regular", size: 15)
    static let tabBarFont  = UIFont(name: "Montserrat-Bold", size: 10)
    static let tabBarFontSelected  = UIFont(name: "Montserrat-Light", size: 10)
    static let navBarButtonFont  = UIFont(name: "Montserrat-Medium", size: 10)
    
    static let formFont = UIFont(name: "Montserrat-Bold", size: 13)
    
    //Regular
    static let nine = UIFont(name: "Montserrat-Regular", size: 9)
    static let ten = UIFont(name: "Montserrat-Regular", size: 10)
    static let eleven = UIFont(name: "Montserrat-Regular", size: 11)
    static let twelve = UIFont(name: "Montserrat-Regular", size: 12)
    static let thirteen = UIFont(name: "Montserrat-Regular", size: 13)
    static let fourteen = UIFont(name: "Montserrat-Regular", size: 14)
    static let fifteen = UIFont(name: "Montserrat-Regular", size: 15)
    static let sixteen = UIFont(name: "Montserrat-Regular", size: 16)
    static let seventeen = UIFont(name: "Montserrat-Regular", size: 17)
    static let eighteen = UIFont(name: "Montserrat-Regular", size: 18)

    
    //Light
    static let tenL = UIFont(name: "Montserrat-Light", size: 10)
    static let elevenL = UIFont(name: "Montserrat-Light", size: 11)
    static let twelveL = UIFont(name: "Montserrat-Light", size: 12)
    static let thirteenL = UIFont(name: "Montserrat-Light", size: 13)
    static let fourteenL = UIFont(name: "Montserrat-Light", size: 14)
    static let fifteenL = UIFont(name: "Montserrat-Light", size: 15)
    static let sixteenL = UIFont(name: "Montserrat-Light", size: 16)
    static let seventeenL = UIFont(name: "Montserrat-Light", size: 17)
    static let eighteenL = UIFont(name: "Montserrat-Light", size: 18)

    
 
    static let elevenB = UIFont(name: "Montserrat-Bold", size: 11)
    static let twelveB = UIFont(name: "Montserrat-Bold", size: 12)
    static let thirteenB = UIFont(name: "Montserrat-Bold", size: 13)
    static let fourteenB = UIFont(name: "Montserrat-Bold", size: 14)
    static let fifteenB = UIFont(name: "Montserrat-Bold", size: 15)
    static let sixteenB = UIFont(name: "Montserrat-Bold", size: 16)
    static let seventeenB = UIFont(name: "Montserrat-Bold", size: 17)
    static let twentyB = UIFont(name: "Montserrat-Bold", size: 21)
    static let twentyOneB = UIFont(name: "Montserrat-Bold", size: 21)
    static let twentyTwoB = UIFont(name: "Montserrat-Bold", size: 22)
    
    struct Form {
        
        static let defaultFont  = UIFont(name: "Montserrat-Medium", size: 13)
        static let title  = UIFont(name: "Montserrat-Regular", size: 13)
        static let subtitle  = UIFont(name: "Montserrat-Light", size: 10)
        static let description  = UIFont(name: "Montserrat-Light", size: 10)

    }

    static func setupAppearance() {
        //navbar appearence
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 15)!]
        //navBarAppearance.barTintColor = Global.appColor
        navBarAppearance.tintColor = UIColor.init(hex: "FCC418")
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "FCC418"),NSAttributedString.Key.font: Global.navBarFont!]
        navBarAppearance.isTranslucent = true
        
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:SPNativeColors.white,
                                                                        NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 30)! ]

         //tabBarAppearance
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = UIColor.init(hex: "FCC418")

        let tabBarItemAppearance = UITabBarItem.appearance()
        tabBarItemAppearance.setTitleTextAttributes([NSAttributedString.Key.font:navBarFont as Any], for: .normal)
        tabBarItemAppearance.setTitleTextAttributes([NSAttributedString.Key.font:self.tabBarFontSelected!], for: .selected)

        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 14)!], for: UIControl.State.normal)

    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
}
