//
//  Extensions+UITableView.swift
//  Kids Vid
//
//  Created by Adem Özsayın on 24.12.2020.
//

import UIKit.UITableView

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: padding, y: 0, width: self.bounds.size.width - 2*padding, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = AppAppearance.Form.title
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}
