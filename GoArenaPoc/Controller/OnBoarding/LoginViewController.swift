//
//  LoginViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 30.01.2021.
//

import UIKit

class LoginViewController: ViewController {

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

//        for family: String in UIFont.familyNames{
//            print(family)
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
    }
    
    @objc
    func loginTapped() {
        if let email = loginView.emailField.textField.text, let password = loginView.passwordField.textField.text {
            delay(0.2) {
                self.loginWith(name: email, pass: password)
            }
        } else {
            self.hideLoading()
        }
    }
    
    func loginWith(name:String, pass:String) {
        if loginView.rememberMeSwitch.checkBox.isChecked {
            GoArenaUser().setRememberMe(bool: true)
            GoArenaUser().setEmailForLoginInfo(email: name)
        } else {
            GoArenaUser().setRememberMe(bool: false)
        }
        loginRequest(name, pass)
        
    }
    
    private func loginRequest (_ name:String, _ password: String) {
        if !name.isEmpty && !password.isEmpty {
            if name.isEmail {
                self.showLoading()
                networkManager.getToken(email: name, password: password) { [weak self] (res, err) in
                    guard let self = self else { return }
                    if let _ = err {
                        DispatchQueue.main.async {
                            self.showAlert(string: "Giriş yapılamadı.")
                            self.hideLoading()
                        }
                    }
                    if let result = res, let token = result.access_token  {
                        User.saveToken(token: token)
                        
                        self.getMyUserInfo()
                    }
                }

            } else {
                self.showAlert(string: "Geçersiz e-posta adresi.")
            }
        }

        

    }
    
    func getMyUserInfo() {
        networkManager.sendRequest(route: .me, User.self) { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.hideLoading()
                }
            }
            if let result = result, let user = result.data {
                User.saveUser(user: user)
                
                DispatchQueue.main.async {
                    self.hideLoading()
                    if let app = UIApplication.shared.delegate as? AppDelegate {
                        if SPApp.Launch.isFirstLaunch {
                            SPApp.Launch.run()
                        }
                        app.openApp()
                    }
                }
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
