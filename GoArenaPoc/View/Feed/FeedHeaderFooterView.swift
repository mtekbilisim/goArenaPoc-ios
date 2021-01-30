//
//  FeedHeaderFooterView.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import UIKit

class FeedHeaderFooterView: UITableViewHeaderFooterView {
    let title = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(title)

        NSLayoutConstraint.activate([
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: 0),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo:contentView.trailingAnchor),
        ])
    }
}

extension FeedHeaderFooterView {
    static let identifier = "FeedHeaderFooterView"
}
