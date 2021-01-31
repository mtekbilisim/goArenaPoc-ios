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
        NotificationCenter.default.addObserver(self, selector:
                                                #selector(keyboardWillShow),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        setupView()

        for family: String in UIFont.familyNames{
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
    @objc
    func loginTapped() {
        if let email = loginView.emailField.textField.text, let password = loginView.passwordField.textField.text {
            loginWith(name: email, pass: password)
        }
    }
    
    func loginWith(name:String, pass:String) {
        if loginView.rememberMeSwitch.checkBox.isChecked {
            GoArenaUser().setRememberMe(bool: true)
            GoArenaUser().setEmailForLoginInfo(email: name)
        } else {
            GoArenaUser().setRememberMe(bool: false)
        }
        doLogin(name, pass)
    }
    
    func doLogin(_ name:String, _ password: String) {
       
        loginRequest(name,password)
    }
    
    private func loginRequest (_ name:String, _ password: String) {
        DispatchQueue.main.async {
            if let app = UIApplication.shared.delegate as? AppDelegate {
                if SPApp.Launch.isFirstLaunch {
                    SPApp.Launch.run()
                }
                app.openApp()
            }
        }
    }
}

extension LoginViewController {
    func setupView() {
        loginView = LoginView()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        loginView.setAnchorConstraintsFullSizeTo(view: view)
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    
    // MARK: - SHOW HIDE KEYBOARD

    @objc func keyboardWillShow(notification: NSNotification) {
        if let k = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2) {
                print("show")
                self.loginView.scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
                self.loginView.scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight )
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.loginView.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        UIView.animate(withDuration: 0.2) {
            print("hide")
            self.loginView.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            self.loginView.scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight - Constants.Numbers.statusBarHeight - 50 )

        }
    }
}
