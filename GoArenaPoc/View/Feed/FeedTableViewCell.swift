//
//  FeedTableViewCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import UIKit
import MBVideoPlayer

protocol FeedTableViewCellDelegate:class {
    func openSelectedPhoto(image: UIImage, indexPath:IndexPath)
}

class FeedTableViewCell: UITableViewCell {
   
    // MARK: - Vars
    
    weak var delegate:FeedTableViewCellDelegate? = nil
    var videoPlayerView =  MBVideoPlayerView()

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
    
    // MARK: - setupView

    private func setupView() {
        
        
        profilePicture = SPDownloadingImageView()
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.backgroundColor = SPNativeColors.blue
        
        title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = ""
        title.font = AppAppearance.seventeen
        
        date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.text = ""
        date.font = AppAppearance.thirteenL
        
        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = ""
        detailLabel.numberOfLines = 2
        detailLabel.font = AppAppearance.fifteen
        
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
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        collectionView =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        //register cells
        collectionView.register(ImagesCollectionViewCell.self,forCellWithReuseIdentifier:ImagesCollectionViewCell.identifier)
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
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
    
    // MARK: - setFeed Data

    func setFeed(_ feed: Feed) {
        self.feed = feed
        switch feed.postType {
        case .IMAGE, .VIDEO:
            self.collectionView.isHidden = false
            collectionViewBottomtConstraint.constant = -12
            self.layoutIfNeeded()
        default:
            self.collectionView.isHidden = true
        }
    
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
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profilePicture.setCorner(radius: profilePicture.frame.width / 2)

    }
}

// MARK: - FeedTableViewCell extensions

extension FeedTableViewCell {
    static let identifier = "FeedTableViewCell"
}

// MARK: - UICollectionViewDelegate

extension FeedTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let feed = self.feed {
            if feed.postType == .IMAGE {
                let images = feed.medias
                return images.count
            } else if feed.postType == .VIDEO {
                return 1
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
        if let feed = self.feed {
            if feed.postType == .IMAGE {
                let images = feed.medias
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.identifier,
                                                              for: indexPath) as! ImagesCollectionViewCell
                cell.imageView.setImage(link: images[indexPath.row].uri)
                return cell

            } else if feed.postType == .VIDEO {

                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier,
                                                              for: indexPath) as! VideoCollectionViewCell
                cell.isUserInteractionEnabled = true

                cell.setData(feed)

                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let uri = URL(string: (feed?.medias[indexPath.row].uri)!) {
            let image = UIImage(data: try! Data(contentsOf: uri))
            delegate?.openSelectedPhoto(image: image!,indexPath: indexPath)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedTableViewCell:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let feed = self.feed {
            if feed.postType == .IMAGE  {
                if feed.medias.count > 1 {
                    return CGSize(width: collectionView.frame.width - 72, height: collectionView.frame.height - 16)
                } else {
                    return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
                }
            } else if feed.postType == .VIDEO {
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            }
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        if let feed = self.feed {
            if feed.postType == .IMAGE  {
                if feed.medias.count > 1 {
                    return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
                } else {
                    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
            } else if feed.postType == .VIDEO {
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
