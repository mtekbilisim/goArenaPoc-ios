//
//  LoginViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 30.01.2021.
//

import UIKit

class LoginViewController: UIViewController {

    var loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupView()
    }


}

extension LoginViewController {
    func setupView() {
        loginView = LoginView()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        loginView.setAnchorConstraintsFullSizeTo(view: view)
    }
}
