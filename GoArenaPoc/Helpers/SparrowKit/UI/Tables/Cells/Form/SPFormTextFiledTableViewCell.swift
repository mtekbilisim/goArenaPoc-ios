// The MIT License (MIT)
// Copyright © 2017 Ivan Vorobei (ivanvorobei@icloud.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

class SPFormTextFiledTableViewCell: UITableViewCell {
    
    var bg = UIView()
    var label: UILabel = UILabel()
    var textField = UITextField.init()
    
    var separatorInsetStyle: SPSeparatorInsetStyle = SPSeparatorInsetStyle.beforeImage {
        didSet {
            layoutSubviews()
        }
    }
    
    var textAligmentToSide: Bool = false {
        didSet {
            if textAligmentToSide {
                self.label.textAlignment = .left
                self.textField.textAlignment = .right
            } else {
                 self.label.textAlignment = .right
                 self.textField.textAlignment = .left
            }
        }
    }
    
    var fixWidthLabel: CGFloat? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {

        self.label.text = "Label"
        self.label.font = AppAppearance.defaultSemiFont
        contentView.addSubview(self.label)
        
        self.textField.font = AppAppearance.defaultFont
        self.textField.placeholder = "Placeholder"
        
        contentView.addSubview(self.textField)
       
        //self.textAligmentToSide = true
        self.textField.textAlignment = .left
        textField.isUserInteractionEnabled = true


    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var labelWidth: CGFloat = self.frame.width 
        if let width = self.fixWidthLabel {
            labelWidth = width
        }
        self.label.frame = CGRect.init(x: padding, y: 4, width: labelWidth, height: 20)

        self.textField.frame = CGRect.init(x: padding, y: 28, width: contentView.frame.width - 2*padding, height: 40)
//
        switch self.separatorInsetStyle {
        case .all:
            self.separatorInset.left = 0
        case .beforeImage:
            self.separatorInset.left = 0
        case .none:
            self.separatorInset.left = contentView.frame.width
        case .auto:
            self.separatorInset.left = contentView.layoutMargins.left
        }
    }
}


