//
//  VideoCollectionViewCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 30.01.2021.
//

import UIKit
import VersaPlayer
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell {
    
    var player = VersaPlayerView()
    var controls = VersaPlayerControls()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  setupView() {
        player = VersaPlayerView()
        player.backgroundColor = SPNativeColors.lightGray2
        player.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(player)
        player.setAnchorConstraintsFullSizeTo(view: contentView, padding: 0)
        
        controls = VersaPlayerControls()
        controls.translatesAutoresizingMaskIntoConstraints = false
        player.addSubview(controls)
        
        controls.centerXAnchor.constraint(equalTo: player.centerXAnchor).isActive = true
        controls.centerYAnchor.constraint(equalTo: player.centerYAnchor).isActive = true

        controls.backgroundColor = SPNativeColors.blue.withAlphaComponent(0.3)
        
        let a = VersaStatefulButton()
        a.activeImage = UIImage(named: "iTunesArtwork")
        player.addSubview(a)
        a.centerXAnchor.constraint(equalTo: player.centerXAnchor).isActive = true
        a.centerYAnchor.constraint(equalTo: player.centerYAnchor).isActive = true
    }
    
    func setData(_ feed: Feed) {
        print(feed.postType?.rawValue)
        if let url = URL.init(string: "https://kidsapi.mtek.me/uploads/_/originals/a668f9f3-bd12-4a03-a489-b931f91612fc.mp4") {
            let item = VersaPlayerItem(url: url)
            
            player.autoplay = false
            player.controls?.behaviour.shouldShowControls = true
            player.renderingView.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            player.set(item: item)
            controls.playPauseButton?.set(active: true)
            
            
        }
        player.use(controls: controls)
        player.controls?.behaviour.shouldShowControls = true
        player.controls?.

    }
}

extension VideoCollectionViewCell {
    static let identifier = "VideoCollectionViewCell"
}
