//
//  AddPostViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import UIKit

class AddPostViewController: ViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SPNativeColors.green
        self.title = "Add Post"
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissView() {
        dismiss()
    }

}
