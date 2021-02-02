//
//  FeedView.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import UIKit
import AVKit
import AVFoundation


protocol FeedViewDelegate:class {
    func openselectedImage(image: UIImage, indexPath:IndexPath)
    func refreshData()
}
class FeedView: UIView {

    var tableView = UITableView()
    var refreshControl = UIRefreshControl()
    var feeds:[Feed] = []
    
    weak var delegate:FeedViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupView

    func setupView() {
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.init(hex: "FCC418")
        
        tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tableView.register(FeedVideoTableViewCell.self,forCellReuseIdentifier: FeedVideoTableViewCell.identifier)
        tableView.register(FeedHeaderFooterView.self,forHeaderFooterViewReuseIdentifier: FeedHeaderFooterView.identifier)
        tableView.refreshControl = refreshControl

        self.addSubview(tableView)
        tableView.setAnchorConstraintsFullSizeTo(view: self)
    }
    
    func setData(_ feeds: [Feed]) {
        self.feeds = feeds
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - like Tapped

    @objc
    func likeButtonTapped(_ sender:UIButton) {
        print(#function)
    }
    
    // MARK: - comment Button Tapped

    @objc
    func commentsTapped(_ sender:UIButton) {
        print(#function)
    }
    
    // MARK: - pull down refresh

    @objc
    func refresh () {
        delegate?.refreshData()
       
    }
}

// MARK: - UITABLEVIEW DELEGATE

extension FeedView:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let section = indexPath.section
        let feed = feeds[section]

        if feed.postType == .VIDEO {
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedVideoTableViewCell.identifier,
                                                     for: indexPath) as! FeedVideoTableViewCell
            cell.playerView.link = feed.medias[0].uri
            cell.setFeed(feed)
            return cell
        } else if feed.postType == .IMAGE {
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier,
                                                     for: indexPath) as! FeedTableViewCell
            cell.isUserInteractionEnabled = true
            cell.delegate = self
            cell.setFeed(feed)
            cell.commentsButton.tag = section
            cell.commentsButton.addTarget(self, action: #selector(commentsTapped), for: .touchUpInside)
            cell.likeButton.tag = section
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier,
                                                     for: indexPath) as! FeedTableViewCell
            cell.isUserInteractionEnabled = true

            cell.setFeed(feed)
            cell.commentsButton.tag = section
            cell.commentsButton.addTarget(self, action: #selector(commentsTapped), for: .touchUpInside)
            cell.likeButton.tag = section
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            return cell
        }
   
    
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView()
            return view
        } else {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:FeedHeaderFooterView.identifier) as! FeedHeaderFooterView
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = feeds[indexPath.section].postType
        switch type {
        case .IMAGE:
            return 420
        case .VIDEO :
            return 360
        default:
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension FeedView:FeedTableViewCellDelegate {

    func openSelectedPhoto(image: UIImage, indexPath:IndexPath) {
        delegate?.openselectedImage(image: image, indexPath:IndexPath(row: 0, section: 0))
    }
}

