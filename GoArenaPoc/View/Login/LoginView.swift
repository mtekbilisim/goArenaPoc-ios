//
//  LoginView.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 30.01.2021.
//

import UIKit

class LoginView: UIView {

    var scrollView = TPKeyboardAvoidingScrollView()
    var logo = UIImageView()
    var enterLabel = UILabel()
    var emailField = TurkcellTextField()
    var passwordField = TurkcellTextField()
    var loginButton = SPButton()
    var rememberMeSwitch = ArenaRadioButton()
    var forgetPasswordButton = SPButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        scrollView = TPKeyboardAvoidingScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor =  UIColor.init(hex: "059FE7")
        self.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        logo = UIImageView()
        logo.image = UIImage(named: "logo2")
        logo.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(logo)
        logo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        logo.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 80).isActive = true
        
        enterLabel = UILabel()
        enterLabel.translatesAutoresizingMaskIntoConstraints = false
        enterLabel.text = "Giriş Yap"
        enterLabel.font = AppAppearance.fifteen
        enterLabel.textColor = .white
        scrollView.addSubview(enterLabel)
        
        let line = UILabel()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = SPNativeColors.customGray
        scrollView.addSubview(line)
        
        line.topAnchor.constraint(equalTo: enterLabel.bottomAnchor, constant: 16).isActive = true
        line.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        line.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true

        enterLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 80).isActive = true
        enterLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32).isActive = true
        enterLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true

        emailField = TurkcellTextField()
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.isRequired = false
        emailField.placeholder = "Kullanıcı Adı"
        emailField.textField.keyboardType = .emailAddress
        emailField.textField.placeholder = "Esra"
        scrollView.addSubview(emailField)

        passwordField = TurkcellTextField()
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.isRequired = false
        passwordField.placeholder = "Şifre"
        passwordField.textField.isSecureTextEntry = true
        passwordField.textField.keyboardType = .default
        passwordField.textField.placeholder = "******"
        scrollView.addSubview(passwordField)
        
        rememberMeSwitch = ArenaRadioButton(frame: CGRect(x:screenWidth - 130,
                                                          y:  450,
                                                         width: 100,
                                                         height: 20))
        rememberMeSwitch.textLabel.text = "Beni Hatırla"
        rememberMeSwitch.textLabel.font = AppAppearance.elevenL
        rememberMeSwitch.delegate = self
        rememberMeSwitch.tagValue = 1
        rememberMeSwitch.checkBox.isChecked = true
        
        scrollView.addSubview(rememberMeSwitch)
        
        loginButton = SPButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("GİRİŞ YAP")
        loginButton.titleLabel?.font = AppAppearance.fifteen
        loginButton.backgroundColor = UIColor.init(hex: "FCC418")
        loginButton.setTitleColor(.white)
        //loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.kidShadow(shadowColor: SPNativeColors.black, cornerRadius: 10)
        scrollView.addSubview(loginButton)
        
        forgetPasswordButton = SPButton()
        forgetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgetPasswordButton.setTitle("Şifremi Unuttum ? ")
        forgetPasswordButton.titleLabel?.font = AppAppearance.twelveL
        forgetPasswordButton.backgroundColor = .clear
        forgetPasswordButton.setTitleColor(.white)
        //loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        scrollView.addSubview(forgetPasswordButton)

        emailField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        emailField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        emailField.topAnchor.constraint(equalTo: enterLabel.bottomAnchor, constant: 50).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 65).isActive = true

        passwordField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 70).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        forgetPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30).isActive = true
        forgetPasswordButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
       
    }
}

// MARK: - KidsRadioButtonDelegate

extension LoginView:ArenaRadioButtonDelegate {
    func valueChanged(tag: Int, value: Bool) {
        if tag == 1 {
            if value {
                self.rememberMeSwitch.checkBox.isChecked = true
            } else {
                self.rememberMeSwitch.checkBox.isChecked = false
            }
        }
    }
}
