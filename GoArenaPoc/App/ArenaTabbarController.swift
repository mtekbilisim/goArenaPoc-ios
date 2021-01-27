//
//  ArenaTabbarController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit
import SwiftIcons

class ArenaTabbarController: UITabBarController {
    
    //let networkManager = NetworkManager()

    var count:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let feedVC = UINavigationController(rootViewController: FeedViewController())
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.setIcon(icon: .fontAwesomeSolid(.home), size: nil, textColor: .lightGray)
//
//        let ReservationVC = SettingsViewController(networkManager: networkManager)
//        let ReservationController = UINavigationController(rootViewController:ReservationVC)
//        ReservationController.title = "Settings"
//        let image2 = UIImage.fontAwesomeIcon(name: .businessTime, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30))
//        ReservationController.tabBarItem.image = image2
//
//
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat", size: 10)!], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 10)!], for: .selected)
//
////        UINavigationBar.appearance().isTranslucent = true
//
        viewControllers = [feedVC]
            

    }
}

extension ArenaTabbarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ArenaTabbarControllerTransition(viewControllers: tabBarController.viewControllers)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let viewControllers = viewControllers else { return false }
        if viewController == viewControllers[selectedIndex] {
            if let nav = viewController as? UINavigationController {
                guard let topController = nav.viewControllers.last else { return true }
                if !topController.isScrolledToTop {
                    topController.scrollToTop()
                    return false
                } else {
                    nav.popViewController(animated: true)
                }
                return true
            }
        }

        return true
    }
}

class ArenaTabbarControllerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 0.3
    
    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }
        
        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart
        
        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            transitionContext.containerView.backgroundColor = .white//Global.appColor

            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }
    
    func getIndex(forViewController vc: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == vc {
                return index
            }
        }
        return nil
    }
}

extension UITabBarController {
    func increaseBadge(indexOfTab: Int, num: String) {
        let tabItem = tabBar.items![indexOfTab]
        tabItem.badgeValue = num
    }
}

extension UIViewController {
    func scrollToTop() {
        func scrollToTop(view: UIView?) {
            guard let view = view else { return }

            switch view {
            case let scrollView as UIScrollView:
                if scrollView.scrollsToTop == true {
                    scrollView.setContentOffset(CGPoint(x: 0.0, y: -scrollView.contentInset.top), animated: true)
                    return
                }
            default:
                break
            }

            for subView in view.subviews {
                scrollToTop(view: subView)
            }
        }

        scrollToTop(view: view)
    }

    // Changed this

    var isScrolledToTop: Bool {
        if self is UITableViewController {
            return (self as! UITableViewController).tableView.contentOffset.y == 0
        }
        for subView in view.subviews {
            if let scrollView = subView as? UIScrollView {
                return (scrollView.contentOffset.y == 0)
            }
        }
        return true
    }
}
