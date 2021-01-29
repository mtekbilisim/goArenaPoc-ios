//
//  FeedViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit

class FeedViewController: ViewController {

    var feedView = FeedView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        setupView()
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
