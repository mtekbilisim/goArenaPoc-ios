//
//  FeedTableViewCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    var title = UILabel()
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout() )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "asdasd"
        contentView.addSubviews([title])
    }    
}

extension FeedTableViewCell {
    static let identifier = "FeedTableViewCell"
}
