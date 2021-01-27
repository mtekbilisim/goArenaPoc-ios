//
//  Extensions+UILabel.swift
//  Kids Vid
//
//  Created by Adem Özsayın on 13.01.2021.
//

import UIKit

extension UILabel {
    var optimalHeight : CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text
            label.sizeToFit()

            return label.frame.height
         }
    }
}
