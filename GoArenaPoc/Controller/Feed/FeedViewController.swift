//
//  FeedViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit

class FeedViewController: ViewController  {

    var feedView = FeedView()
    var feeds:[Feed] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.tabBarController?.delegate = self
        setupView()
        self.showLoading()
        setDummyData()
    }
    
    func setDummyData() {
        for i in 0...20 {
            var type: PostType = .unknown
            var images: [String] = []
            var detailText = ""
            if i % 4 == 0 {
                type = .video
                images = []
                detailText = "\(type.rawValue) Ürün kategorisi bazında, yin"
            } else if i % 5 == 0 {
                type = .images
                images = ["https://images.pexels.com/photos/235791/pexels-photo-235791.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                          "https://images.pexels.com/photos/1564655/pexels-photo-1564655.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"]
                detailText =  " \(type.rawValue) Ürün kategorisi bazında, yine içinde bulunduğumuz ayın, haftalık verileri gösterilecektir. "
            } else {
                type = .text
                images = []
                detailText =  " \(type.rawValue) Ürün kategorisi bazında, yine içinde bulunduğumuz ayın, haftalık verileri gösterilecektir. Ürün kategorisi bazında, yi https://pbs.twimg.com/profile_images/997370208531746816/k "
            }
            let feed = Feed(id: i,
                            picture: "https://pbs.twimg.com/profile_images/997370208531746816/kmS7w0vf.jpg",
                            name: "Adem Özsayın",
                            postType: type,
                            detailText: detailText,
                            likes: "47",
                            comments: "32",
                            date: "2 hour",
                            images: images)
            self.feeds.append(feed)
        }
        DispatchQueue.main.async {
            delay(1) {
                self.feedView.setData(self.feeds)
                self.hideLoading()
            }
        }
    }
}

extension FeedViewController {
    private func setupView() {
        feedView = FeedView()
        feedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(feedView)
        feedView.setAnchorConstraintsFullSizeTo(view: view)
    }
}

extension FeedViewController:UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        let tabBarIndex = tabBarController.selectedIndex

        print(tabBarIndex)

        if tabBarIndex == 0 {
            self.feedView.tableView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}
