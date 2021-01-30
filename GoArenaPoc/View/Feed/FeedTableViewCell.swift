//
//  FeedTableViewCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
   
    var profilePicture = SPDownloadingImageView()
    
    var title = UILabel()
    
    var date = UILabel()
    
    var detailLabel = UILabel()
    
    var likeButton = SPButton()
    
    var commentsButton = SPButton()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout() )
    
    var collectionViewBottomtConstraint = NSLayoutConstraint()
    
    var feed:Feed?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        collectionView =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        //register cells
        collectionView.register(SPImageCollectionViewCell.self,forCellWithReuseIdentifier:"cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.showsHorizontalScrollIndicator = false

        //constraints
        contentView.addSubviews([ profilePicture, title, date, detailLabel, likeButton, commentsButton,collectionView])
        
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
        
        collectionView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor,constant: padding).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0).isActive = true
        collectionViewBottomtConstraint = collectionView.bottomAnchor.constraint(equalTo: likeButton.topAnchor)
        collectionViewBottomtConstraint.constant = -12
        collectionViewBottomtConstraint.isActive = true
        
    }
    
    func setFeed(_ feed: Feed) {
        self.feed = feed
        switch feed.postType {
        case .images, .video:
            self.collectionView.isHidden = false
            collectionViewBottomtConstraint.constant = -12
            self.layoutIfNeeded()
        default:
            self.collectionView.isHidden = true
        }
    
        profilePicture.setImage(link: feed.picture!)
        title.text = feed.name
        date.text = feed.date
        detailLabel.text = feed.detailText
        likeButton.setTitle(feed.likes!)
        commentsButton.setTitle(feed.comments!)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profilePicture.setCorner(radius: profilePicture.frame.width / 2)

    }
}

extension FeedTableViewCell {
    static let identifier = "FeedTableViewCell"
}

extension FeedTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let feed = self.feed {
            if feed.postType == .images, let images = feed.images  {
                return images.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SPImageCollectionViewCell
        cell.imageView.setCorner(radius: 16)
        if let feed = self.feed {
            if feed.postType == .images, let images = feed.images  {
                cell.imageView.setImage(link: images[indexPath.row])
            }
        }
        return cell
    }
}

extension FeedTableViewCell:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let feed = self.feed {
            if feed.postType == .images  {
                return CGSize(width: collectionView.frame.width - 72, height: collectionView.frame.height - 16)
            }
        }
        return CGSize(width: 0, height: 0)
    }
    
}
