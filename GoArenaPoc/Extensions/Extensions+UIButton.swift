//
//  Extensions+UIButton.swift
//  Kids Vid
//
//  Created by Adem Özsayın on 24.12.2020.
//

import UIKit


public extension UIButton {

    func alignTextBelow(spacing: CGFloat = 2.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
           // self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            self.titleEdgeInsets = UIEdgeInsets(top: imageSize.height + spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font as Any])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }

}

extension UIButton {

    // MARK: - Constants
    private enum Constants {
        static let animationDuration: TimeInterval = 0.1
        static let transformScale: CGFloat = 0.96
    }

    // MARK: -  Public Methods
    
    func animateTap(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: Constants.transformScale,
                                                y: Constants.transformScale)
        }, completion: { finished in
            UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
                self?.transform = CGAffineTransform.identity
            }, completion: completion)
        })
    }
}

extension UIButton {
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: image.size.width / 2 - 32)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }

    func rightImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left:image.size.width / 2, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .right
        self.imageView?.contentMode = .scaleAspectFit
    }
}
