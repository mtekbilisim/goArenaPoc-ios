//
//  CircularTransition.swift
//  Makas
//
//  Created by Adem Özsayın on 2.09.2020.
//  Copyright © 2020 Adem Özsayın. All rights reserved.
//

import UIKit
import Foundation


protocol CircleTransitionable {
//    var triggerButton: UIButton { get }
//    var contentTextView: UITextView { get }
    var mainView: UIView { get }
}

class CircularTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var context: UIViewControllerContextTransitioning?

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.context = transitionContext
        
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? CircleTransitionable,
          let toViewController = transitionContext.viewController(forKey: .to) as? CircleTransitionable,
          let snapshot = fromViewController.mainView.snapshotView(afterScreenUpdates: false) else {
            transitionContext.completeTransition(false)
            return
        }
        

                
        // The view that acts as the superview for the views involved in the transition.
        let containerView = transitionContext.containerView
        
        // Set backgroundColor for containerView to be the same as DetailViewController
        let backgroundView = UIView()
        backgroundView.frame = toViewController.mainView.frame
//        backgroundView.backgroundColor = toViewController.mainView.backgroundColor
//        backgroundView.backgroundColor = .red
        
        
        containerView.addSubview(backgroundView)

        
        // Animate the snapshot and not the view itself to not mess with layout.
        containerView.addSubview(snapshot)

        
        // Next, remove the actual view you’re coming from since you won’t be needing it anymore.
        
        // Remove main view from view controller since we now have the snapshot instead.
        fromViewController.mainView.removeFromSuperview()
        
        
        // Animate snapshot away
        self.animateViewOffscreen(fromView: snapshot)
        
        
        // Add the new view (DetailViewController) controllers main view to containerView
        containerView.addSubview(toViewController.mainView)
        
        // Unwrap ViewController to access @IBOutlet
        guard let mainViewController = fromViewController as? SplashViewController else { return }
        
        // Animate
        self.animate(toView: toViewController.mainView, fromTriggerButton: mainViewController.triggerButton)
        
    }
    
    func animate(toView: UIView, fromTriggerButton triggerButton: UIButton) {
        
        let rect = CGRect(x: triggerButton.frame.origin.x,
                          y: triggerButton.frame.origin.y,
                          width: triggerButton.frame.width,
                          height: triggerButton.frame.width)
        
        let circleMaskPathInitial = UIBezierPath(ovalIn: rect)
        
        /**
             Here’s what this does:

             1. Defines a point that’s the full screen’s height above the top of the screen.
             2. Calculates the radius of your new circle by using the Pythagorean Theorem: a² + b² = c².
             3. Creates your new bezier path by taking the current frame of the circle and “insetting” it by a negative amount in both directions, thus pushing it out to go fully beyond the bounds of the screen in both directions.
         */
        
        // 1
        let fullHeight = toView.bounds.height
        let extremePoint = CGPoint(x: triggerButton.center.x,
                                   y: triggerButton.center.y - fullHeight)
        // 2
        let radius = sqrt((extremePoint.x * extremePoint.x) +
                          (extremePoint.y * extremePoint.y))
        // 3
        let circleMaskPathFinal = UIBezierPath(ovalIn: triggerButton.frame.insetBy(dx: -radius,
                                                                                   dy: -radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        
        // Mask target view
        toView.layer.mask = maskLayer
        
        // Create animation. Cannot use UIView.animate() here because of CALayer.
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.duration = 0.3

        /*
         Instead of using completion blocks like UIView animations, CAAnimations use a delegate with callbacks to signal completion. While you don’t technically require one for this animation, you’ll implement the delegate to better understand it.
         */
        maskLayerAnimation.delegate = self
        
        // Add animation to maskLayer
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
    // Animate
    func animateViewOffscreen(fromView: UIView) {

//        fromView.clipsToBounds = true
        
        UIView.animate(withDuration: 60,
                       delay: 0.0,
                       options: [.curveEaseIn],
                       animations: {
                        
//                        fromView.layer.cornerRadius = 150.0
                        
                        // Animate off center
                        fromView.center = CGPoint(x: fromView.center.x - 1300, y: fromView.center.y + 1500)
                        fromView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: nil)
    }
}

// MARK: - CAAnimationDelegate
extension CircularTransition: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.context?.completeTransition(true)
    }
}



