//
//  VideoCollectionViewCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 30.01.2021.
//

import UIKit
import AVFoundation
import MBVideoPlayer

class VideoCollectionViewCell: UICollectionViewCell {
    
    var playerView = MBVideoPlayerView(configuration: nil, theme: nil, header: nil)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  setupView() {
        
        
        playerView = MBVideoPlayerView(configuration: nil, theme: nil, header: nil)
        playerView.pinEdges(to: self)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playerView)
        playerView.setAnchorConstraintsFullSizeTo(view: contentView)
    }
    
    func setData(_ feed: Feed) {
//        let playerItems = [
//            PlayerItem(title: feed.name ?? "", url: "https://kidsapi.mtek.me/uploads/_/originals/a668f9f3-bd12-4a03-a489-b931f91612fc.mp4", thumbnail: "1"),
//            ]
//        
//        if let currentItem = playerItems.first {
//            playerView.setPlayList(currentItem: currentItem, items: playerItems, fullScreenView: contentView)
//        }
    }
}

extension VideoCollectionViewCell {
    static let identifier = "VideoCollectionViewCell"
}
