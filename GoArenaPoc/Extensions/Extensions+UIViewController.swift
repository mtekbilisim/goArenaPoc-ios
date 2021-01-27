//
//  Extensions+UIViewController.swift
//  Kids Vid
//
//  Created by Adem Özsayın on 24.12.2020.
//

import Foundation
import UIKit

extension UIViewController {

    func presentInFullScreen(_ viewController: UIViewController,
                           animated: Bool,
                           completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
    
    func getSafeArea() -> UILayoutGuide {
        let guide = view.safeAreaLayoutGuide
        return guide
    }

}
