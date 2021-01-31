//
//  ArenaRadioButton.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 31.01.2021.
//

import UIKit
import SimpleCheckbox

protocol ArenaRadioButtonDelegate:class {
    func valueChanged(tag: Int, value:Bool)
}

class ArenaRadioButton: UIView {
    
    weak var delegate:ArenaRadioButtonDelegate? = nil
    var textLabel = UILabel()
    var tagValue:Int? = 0
    
    lazy var checkBox: Checkbox = {
        let box = Checkbox()
        box.tag = self.tag
        box.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        box.tintColor = .green
        box.valueChanged = { (value) in
            self.delegate?.valueChanged(tag: self.tagValue!, value: value)
        }
        box.increasedTouchRadius = 5 // Default
        box.borderStyle = .circle
        box.checkmarkStyle = .tick
        box.borderLineWidth = 3
        box.uncheckedBorderColor = SPNativeColors.customGray
        box.checkedBorderColor = SPNativeColors.green
        box.checkmarkSize = 0.4
        box.checkmarkColor = SPNativeColors.white
        
        //box.addTarget(self, action: #selector(circleBoxValueChanged(sender:)), for: .valueChanged)
        
        return box
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    //common func to init our view
    func setupView() {

        textLabel = UILabel()
        textLabel.frame = CGRect(x: 30, y: 5, width: self.frame.width , height: 20)
        textLabel.font = UIFont(name: "Montserrat-Light", size: 15)
        textLabel.text = "checkbox"
        textLabel.textColor = .white
        
        self.addSubview(checkBox)
        self.addSubview(textLabel)
        
    }
    
    @objc func circleBoxValueChanged(sender: Checkbox) {
        print("circleBox value change: \(sender.isChecked)")
    }

}


