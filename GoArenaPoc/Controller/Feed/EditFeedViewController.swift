//
//  EditFeedViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 3.02.2021.
//

import UIKit

class EditFeedViewController: ViewController {

    var feed:Feed?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideTabbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.showTabbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "İleti Güncelleme"
    }
    
    func setFeed(_ feed:Feed) {
        self.feed = feed
        #if DEBUG
        print(feed)
        #endif
    }
}
