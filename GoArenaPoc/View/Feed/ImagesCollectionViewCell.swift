//
//  ImagesCollectionViewCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 30.01.2021.
//

import UIKit

class ImagesCollectionViewCell: SPCollectionViewCell {
    
    let imageView = SPDownloadingImageView()
    
    override func commonInit() {
        super.commonInit()
        
        self.addSubview(self.imageView)
        SPConstraints.setEqualSizeSuperview(for: self.imageView)
        
        self.configure()
    }
    
    private func configure() {
        self.currentIndexPath = nil
        //self.imageView.removeImage()
        self.imageView.contentMode = .scaleAspectFill
        //self.imageView.layer.masksToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.layer.cornerRadius = 12
    }
}

extension ImagesCollectionViewCell {
    static let identifier = "ImagesCollectionViewCell"
}
