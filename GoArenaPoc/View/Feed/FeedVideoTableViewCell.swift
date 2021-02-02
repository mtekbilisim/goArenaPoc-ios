//
//  FeedVideoTableViewCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 30.01.2021.
//

import UIKit


class FeedVideoTableViewCell: UITableViewCell {
   
    // MARK: - Vars
    
    var profilePicture = SPDownloadingImageView()
    
    var title = UILabel()
    
    var date = UILabel()
    
    var detailLabel = UILabel()
    
    var likeButton = SPButton()
    
    var commentsButton = SPButton()
   
    var feed:Feed?
    
    var playerView = SPVideoPlayerView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupView

    private func setupView() {
        
        
        profilePicture = SPDownloadingImageView()
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.backgroundColor = SPNativeColors.blue
        
        title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = ""
        title.font = AppAppearance.twelveB
        
        date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.text = ""
        date.font = AppAppearance.twelveL
        
        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = ""
        detailLabel.numberOfLines = 2
        detailLabel.font = AppAppearance.elevenL
        
        likeButton = SPButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(UIImage(named: "heart")!, for: .normal)
        likeButton.titleLabel?.font = AppAppearance.twelveB
        likeButton.setTitleColor(UIColor.init(hex: "3E1B74"))
        let icon = UIImage(named: "heart")
        likeButton.setImage(icon!)
        likeButton.semanticContentAttribute = .forceLeftToRight
        likeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12);
        
        commentsButton = SPButton()
        commentsButton.translatesAutoresizingMaskIntoConstraints = false
        commentsButton.titleLabel?.font = AppAppearance.twelveB
        commentsButton.setTitleColor(UIColor.init(hex: "3E1B74"))
        let icon1 = UIImage(named: "comments")
        commentsButton.setImage(icon1!)
        commentsButton.semanticContentAttribute = .forceLeftToRight
        commentsButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5);
        

        playerView = SPVideoPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.backgroundColor = SPNativeColors.blue.withAlphaComponent(0.4)
        contentView.addSubview(playerView)
        
        //constraints
        contentView.addSubviews([ profilePicture, title, date, detailLabel, likeButton, commentsButton])
        
        profilePicture.setAnchorConstraintsEqualTo(widthAnchor: 40,
                                                   heightAnchor: 40,
                                                   topAnchor: (contentView.topAnchor, 16),
                                                   bottomAnchor: nil,
                                                   leadingAnchor: (contentView.leadingAnchor, 16),
                                                   trailingAnchor: nil)
        
        title.setAnchorConstraintsEqualTo(widthAnchor: nil,
                                                   heightAnchor: nil,
                                                   topAnchor: (profilePicture.topAnchor, 4),
                                                   bottomAnchor: nil,
                                                   leadingAnchor: (profilePicture.trailingAnchor, 8),
                                                   trailingAnchor: nil)
        
        date.setAnchorConstraintsEqualTo(widthAnchor: nil,
                                                   heightAnchor: nil,
                                                   topAnchor: (title.bottomAnchor, 4),
                                                   bottomAnchor: nil,
                                                   leadingAnchor: (profilePicture.trailingAnchor, 8),
                                                   trailingAnchor: nil)
        
        detailLabel.setAnchorConstraintsEqualTo(widthAnchor: nil,
                                                   heightAnchor: nil,
                                                   topAnchor: (date.bottomAnchor, 16),
                                                   bottomAnchor: nil,
                                                   leadingAnchor: (contentView.leadingAnchor, 16),
                                                   trailingAnchor: (contentView.trailingAnchor, -16))
        
        likeButton.setAnchorConstraintsEqualTo(widthAnchor: nil,
                                                   heightAnchor: nil,
                                                   topAnchor: nil,
                                                   bottomAnchor: (contentView.bottomAnchor, -16),
                                                   leadingAnchor: (contentView.leadingAnchor, 16),
                                                   trailingAnchor: nil )
        
        commentsButton.setAnchorConstraintsEqualTo(widthAnchor: nil,
                                                   heightAnchor: nil,
                                                   topAnchor: nil,
                                                   bottomAnchor: (contentView.bottomAnchor, -12),
                                                   leadingAnchor: (likeButton.trailingAnchor, 32),
                                                   trailingAnchor: nil )
        
        playerView.setAnchorConstraintsEqualTo(widthAnchor: nil,
                                                   heightAnchor: nil,
                                                   topAnchor: (detailLabel.bottomAnchor, 16),
                                                   bottomAnchor: (commentsButton.topAnchor, -12),
                                                   leadingAnchor: (contentView.leadingAnchor, 0),
                                                   trailingAnchor: (contentView.trailingAnchor, 0) )
    }
    
    // MARK: - setFeed Data

    func setFeed(_ feed: Feed) {
        self.feed = feed
        profilePicture.setImage(link: feed.user.avatar ?? "")
        title.text = feed.user.username ?? ""
        if let datepost = feed.postDate {
            date.text = datepost

//            let postDate = date.toDateString(dateFormatter: DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ssZ"), outputFormat: "HH:mm")
//            print(postDate)
//            date.text = postDate!.timeAgoSinceDate
        }

        detailLabel.text = feed.title
        if let likeCount = feed.likes {
            likeButton.setTitle("\(likeCount)")
        }
        
        if let count = feed.comments?.count, count > 0 {
            commentsButton.setTitle("\(count)")
        } else {
            commentsButton.setTitle("0")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profilePicture.setCorner(radius: profilePicture.frame.width / 2)

    }
}

// MARK: - FeedTableViewCell extensions

extension FeedVideoTableViewCell {
    static let identifier = "FeedVideoTableViewCell"
}
