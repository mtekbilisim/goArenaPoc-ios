//
//  TransitionCoordinator.swift
//  Makas
//
//  Created by Adem Özsayın on 2.09.2020.
//  Copyright © 2020 Adem Özsayın. All rights reserved.
//

import UIKit
import Foundation

class TransitionCoordinator: NSObject, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircularTransition()
    }
}
