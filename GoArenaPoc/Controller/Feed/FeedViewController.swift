//
//  FeedViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit

class FeedViewController: ViewController  {

    // MARK: - VARs
    var feedView = FeedView()
    var feeds:[Feed] = []
    var shouldTop:Bool = false
   
    // MARK: - LifeCycles

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        shouldTop = false
        delay(0.1) {
            self.shouldTop = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.feedDone),
                                               name: NSNotification.Name(rawValue: Notifs.Feed.posted.rawValue),
                                               object: nil)
        self.title = "Feed"
        self.tabBarController?.delegate = self
        setupView()
        getFeeds()
    }
    // MARK: - setData

    func getFeeds() {
        self.showLoading()
        networkManager.sendRequest(route: .feeds, [Feed].self) { [ weak self] (result, error) in
            guard let self = self else { return }
            if let _ = error {
                self.showAlert(string: "Bir sorun oluştu")
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.feedView.refreshControl.endRefreshing()
                }
            }
            if let result = result {
                self.feeds = result.data ?? []
                print(result)
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.feedView.refreshControl.endRefreshing()
                    self.feedView.setData(self.feeds)
                    if self.feeds.count == 0 {
                        let alert = UIAlertController(title: "", message: "no data", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "Tamam", style: .default)
                        alert.addAction(okButton)
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    @objc func feedDone(notification: Notification) {
        self.showSuccessMessage(message: "İletiniz  gönderilmiştir.")
    }
    
    func showOptions(feed: Feed) {

        let alert = UIAlertController(title: "Seçiniz", message: nil, preferredStyle: .actionSheet)
       
        alert.addAction(UIAlertAction(title: "Gönderiyi Düzelt ", style: .default, handler: { _ in
            self.editFeed(feed:feed)
        }))
        
        alert.addAction(UIAlertAction(title: "Sil", style: .destructive, handler: { _ in
            self.deleteFeed(feed:feed)
        }))

        alert.addAction(UIAlertAction.init(title: "İptal", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
    }
    
    func editFeed(feed:Feed) {
        let editVC = AddPostViewController(networkManager: self.networkManager)
        editVC.setFeed(feed)
        let vc = UINavigationController(rootViewController:editVC)
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        present(vc, animated: true, completion: nil)

    }
    
    func deleteFeed(feed:Feed) {
        guard let feedId = feed.id else { return }
        self.showLoading()
        networkManager.sendRequest(route: .deleteFeed(feedId: feedId), ArenaResponse.self) { (result, error) in
            self.getFeeds()
        }
    }
}

// MARK: - extensions setupview

extension FeedViewController {
    private func setupView() {
        feedView = FeedView()
        feedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(feedView)
        feedView.delegate = self
        feedView.setAnchorConstraintsFullSizeTo(view: view)
    }
}

// MARK: - UITabBarControllerDelegate

extension FeedViewController:UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        let tabBarIndex = tabBarController.selectedIndex
        print(tabBarIndex)
        if tabBarIndex == 0 && shouldTop {
            self.feedView.tableView.setContentOffset(CGPoint(x: 0, y: -Constants.Numbers.topSafeAreaHeight
                                                                - Constants.Numbers.navBarHeight), animated: true)
        }
    }
}

extension FeedViewController: FeedViewDelegate {
    func moreTapped(feed: Feed) {
        showOptions(feed: feed)
    }
    
    func openselectedImage(image: UIImage, indexPath:IndexPath) {
        let imageInfo  = GSImageInfo(image: image, imageMode: .aspectFit)
        let transitionInfo = GSTransitionInfo(fromView: self.feedView)
        let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
        imageViewer.dismissCompletion = {
            print("dismissCompletion")
        }
        present(imageViewer, animated: true, completion: nil)
    }
    
    func refreshData() {
        getFeeds()
    }
    
}
