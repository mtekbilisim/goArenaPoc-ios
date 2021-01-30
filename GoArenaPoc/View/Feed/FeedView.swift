//
//  FeedView.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import UIKit

class FeedView: UIView {

    var tableView = UITableView()
    var feeds:[Feed] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        // Register the custom header view.
        tableView.register(FeedHeaderFooterView.self,forHeaderFooterViewReuseIdentifier: FeedHeaderFooterView.identifier)
        self.addSubview(tableView)
        tableView.setAnchorConstraintsFullSizeTo(view: self)
    }
    
    func setData(_ feeds: [Feed]) {
        self.feeds = feeds
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc
    func likeButtonTapped(_ sender:UIButton) {
        print(#function)
    }
    
    @objc
    func commentsTapped(_ sender:UIButton) {
        print(#function)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        cell.isUserInteractionEnabled = true
        let section = indexPath.section
        let feed = feeds[section]
        cell.setFeed(feed)
        cell.commentsButton.tag = section
        cell.commentsButton.addTarget(self, action: #selector(commentsTapped), for: .touchUpInside)
        cell.likeButton.tag = section
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:FeedHeaderFooterView.identifier) as! FeedHeaderFooterView
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = feeds[indexPath.section].postType
        switch type {
        case .images:
            return 420
        case .video :
            return 360
        default:
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



