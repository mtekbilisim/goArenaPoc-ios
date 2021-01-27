//
//  Extensions+UICollectionView.swift
//  Kids Vid
//
//  Created by Adem Özsayın on 24.12.2020.
//

import UIKit

extension UICollectionView{

    func noDataFound(_ dataCount:Int, _ text:String?, _ textColor:UIColor?){
        if dataCount <=  0 {

            let label = UILabel()
            label.frame = self.frame
            label.frame.origin.x = 0
            label.frame.origin.y = 0
            label.frame.set(width: self.frame.width * 0.8)
            label.numberOfLines = 0
            label.textAlignment = .center
            if let text = text {
                label.text = text
            } else {
                label.text = "No data found :("
            }
            label.font = AppAppearance.defaultFont
            if let textColor = textColor {
                label.textColor = textColor
            } else {
                label.textColor = .white
            }
            self.backgroundView = label
        }else{
            self.backgroundView = nil
        }
    }
    
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}


extension UICollectionViewCell {
    func shadowDecorate(radius: CGFloat) {
        //let radius: CGFloat = 12
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.yellow.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowRadius = 1.1
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
