//
//  FeedViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit

class FeedViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        view.backgroundColor = SPNativeColors.customGray
        
        
        let button = SPButton()
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.setTitle("asdad")
        button.frame = CGRect(x: 20, y: 210, width: 222, height: 20)
        view.addSubview(button)

    }
    
    @objc func tapped() {
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }



}
