//
//  TurkcellTextField.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 31.01.2021.
//
import UIKit

class TurkcellTextField: UIView {

    var reuqiredLabel = UILabel()
    
    var isRequired:Bool = true {
        didSet {
            self.reuqiredLabel.isHidden = !isRequired
            reuqiredLabel.topAnchor.constraint(equalTo: placeholderLabel.topAnchor, constant: 0).isActive = true
            reuqiredLabel.leadingAnchor.constraint(equalTo: placeholderLabel.trailingAnchor, constant: 4).isActive = true

        }
    }
    
    var placeholder:String = "" {
        didSet {
            self.placeholderLabel.text = self.placeholder
        }
    }
    var placeholderLabel = UILabel()
    
    var textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.backgroundColor = .clear

        placeholderLabel = UILabel()
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.font = AppAppearance.thirteen
        placeholderLabel.textColor = UIColor.init(hex: "F4F4F4")
        placeholderLabel.text = placeholder
        self.addSubview(placeholderLabel)
       
        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = AppAppearance.fifteenL
        textField.setLeftPaddingPoints(padding)
        textField.delegate = self
        textField.layer.shadowColor = UIColor(red: 0.886, green: 0.878, blue: 0.89, alpha: 0.2).cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 0
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white

        self.addSubview(textField)
       
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        reuqiredLabel = UILabel()
        reuqiredLabel.translatesAutoresizingMaskIntoConstraints = false
        reuqiredLabel.text = "*"
        reuqiredLabel.textColor = .red
        self.addSubview(reuqiredLabel)
        
        reuqiredLabel.topAnchor.constraint(equalTo: placeholderLabel.topAnchor, constant: 0).isActive = true
        reuqiredLabel.leadingAnchor.constraint(equalTo: placeholderLabel.trailingAnchor, constant: 4).isActive = true


               
    }
    func getText() -> String {
        var txt = ""
        if let t = self.textField.text {
            txt =  t
        }
        return txt
    }
    
}

extension TurkcellTextField:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        #if DEBUG
        print("start")
        #endif
    }
}
