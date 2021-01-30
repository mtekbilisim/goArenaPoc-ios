//
//  LoginView.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 30.01.2021.
//

import UIKit

class LoginView: UIView {

    var logo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor =  UIColor.init(hex: "059FE7")
        logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logo)
        logo.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logo.topAnchor.constraint(equalTo: self.topAnchor,constant: 100).isActive = true
    }
}
