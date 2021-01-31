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
    static let defaultFont = UIFont(name: "TurkcellSatura", size: 13)
    static let defaultSemiFont = UIFont(name: "TurkcellSatura", size: 10)
    
    static let defaultHeaderFont = UIFont(name: "Montserrat-Medium", size: 18)
    static let cellTitle = UIFont(name: "Montserrat-Regular", size: 16)
    static let pageTitle = UIFont(name: "Montserrat-Bold", size: 15)

    static let regularFont = "TurkcellSatura"
    static let boldFont    = "TurkcellSatura-Bold"
    static let navBarFont  = UIFont(name: "TurkcellSatura", size: 15)
    static let tabBarFont  = UIFont(name: "Montserrat-Bold", size: 10)
    static let tabBarFontSelected  = UIFont(name: "TurkcellSatura", size: 10)
    static let navBarButtonFont  = UIFont(name: "Montserrat-Medium", size: 10)
    
    static let formFont = UIFont(name: "Montserrat-Bold", size: 13)
    
    //Regular
    static let nine = UIFont(name: "TurkcellSatura", size: 9)
    static let ten = UIFont(name: "TurkcellSatura", size: 10)
    static let eleven = UIFont(name: "TurkcellSatura", size: 11)
    static let twelve = UIFont(name: "TurkcellSatura", size: 12)
    static let thirteen = UIFont(name: "TurkcellSatura", size: 13)
    static let fourteen = UIFont(name: "TurkcellSatura", size: 14)
    static let fifteen = UIFont(name: "TurkcellSatura", size: 15)
    static let sixteen = UIFont(name: "TurkcellSatura", size: 16)
    static let seventeen = UIFont(name: "TurkcellSatura", size: 17)
    static let eighteen = UIFont(name: "TurkcellSatura", size: 18)

    
    //Light
    static let tenL = UIFont(name: "TurkcellSaturaMed", size: 10)
    static let elevenL = UIFont(name: "TurkcellSaturaMed", size: 11)
    static let twelveL = UIFont(name: "TurkcellSaturaMed", size: 12)
    static let thirteenL = UIFont(name: "TurkcellSaturaMed", size: 13)
    static let fourteenL = UIFont(name: "TurkcellSaturaMed", size: 14)
    static let fifteenL = UIFont(name: "TurkcellSaturaMed", size: 15)
    static let sixteenL = UIFont(name: "TurkcellSaturaMed", size: 16)
    static let seventeenL = UIFont(name: "TurkcellSaturaMed", size: 17)
    static let eighteenL = UIFont(name: "TTurkcellSaturaMed", size: 18)

    
 
    static let elevenB = UIFont(name: "TurkcellSatura-Bold", size: 11)
    static let twelveB = UIFont(name: "TurkcellSatura-Bold", size: 12)
    static let thirteenB = UIFont(name: "TurkcellSatura-Bold", size: 13)
    static let fourteenB = UIFont(name: "TurkcellSatura-Bold", size: 14)
    static let fifteenB = UIFont(name: "TurkcellSatura-Bold", size: 15)
    static let sixteenB = UIFont(name: "TurkcellSatura-Bold", size: 16)
    static let seventeenB = UIFont(name: "TurkcellSatura-Bold", size: 17)
    static let twentyB = UIFont(name: "TurkcellSatura-Bold", size: 21)
    static let twentyOneB = UIFont(name: "TurkcellSatura-Bold", size: 21)
    static let twentyTwoB = UIFont(name: "TurkcellSatura-Bold", size: 22)
    
    struct Form {
        static let defaultFont  = UIFont(name: "TurkcellSatura", size: 13)
        static let title  = UIFont(name: "TurkcellSatura", size: 13)
        static let subtitle  = UIFont(name: "TurkcellSatura", size: 10)
        static let description  = UIFont(name: "TurkcellSatura", size: 10)
    }

    static func setupAppearance() {
        //navbar appearence
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "TurkcellSatura-Bold", size: 15)!]
        //navBarAppearance.barTintColor = Global.appColor
        navBarAppearance.tintColor = UIColor.init(hex: "FCC418")
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "FCC418"),NSAttributedString.Key.font: Global.navBarFont!]
        navBarAppearance.isTranslucent = true
        
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:SPNativeColors.white,
                                                                        NSAttributedString.Key.font: UIFont(name: "TurkcellSatura", size: 30)! ]

         //tabBarAppearance
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = UIColor.init(hex: "FCC418")

        let tabBarItemAppearance = UITabBarItem.appearance()
        tabBarItemAppearance.setTitleTextAttributes([NSAttributedString.Key.font:navBarFont as Any], for: .normal)
        tabBarItemAppearance.setTitleTextAttributes([NSAttributedString.Key.font:self.tabBarFontSelected!], for: .selected)

        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "TurkcellSatura", size: 14)!], for: UIControl.State.normal)

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
