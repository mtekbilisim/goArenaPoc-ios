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
        feedVC.tabBarItem.setIcon(icon: .fontAwesomeSolid(.home), size: nil, textColor: SPNativeColors.black)
        
        let addpost = AddPostViewController()
        let button = SPButton()
        let toMakeButtonUp = tabBar.frame.height / 2
        button.frame = CGRect(x: 0.0, y: 0.0, width:  tabBar.frame.height, height:  tabBar.frame.height)
        button.backgroundColor = UIColor.init(hex: "1EC997")
        button.setCorner(radius: toMakeButtonUp)
        button.setImage(UIImage(named: "camera")!)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

        if Device.isIPhoneXSimilar() {
            var center: CGPoint = tabBar.center
            center.y = center.y -  tabBar.frame.height
            button.center = center
        } else {
            var center: CGPoint = tabBar.center
            center.y = center.y -  toMakeButtonUp  //heightDifference / 2.0
            button.center = center
        }
        button.addTarget(self, action: #selector(addPostTapped), for:.touchUpInside)
        view.addSubview(button)

        let settingsVC = SettingsViewController()
        let settingsController = UINavigationController(rootViewController:settingsVC)
        settingsController.title = "Settings"
        settingsController.tabBarItem.setIcon(icon: .dripicon(.user), size: nil, textColor: SPNativeColors.black)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 10)!], for: .selected)
        viewControllers = [feedVC,addpost, settingsController]
    }
    
    @objc func addPostTapped() {
        let vc = AddPostViewController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        present(vc)
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

extension UIImage{

    var roundMyImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
            ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    func resizeMyImage(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))

        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    func squareMyImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: self.size.width, height: self.size.width))

        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.width))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
