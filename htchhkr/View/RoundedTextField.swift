//
//  RoundedTextField.swift
//  htchhkr
//
//  Created by Spencer Yang on 1/5/18.
//  Copyright © 2018 Seungho Yang. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    
    var textRectOffset: CGFloat = 20
    
    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0 + textRectOffset, y: 0 + (textRectOffset * 0.75), width: self.frame.width - textRectOffset, height: self.frame.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0 + textRectOffset, y: 0 + (textRectOffset * 0.75), width: self.frame.width - textRectOffset, height: self.frame.height)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0 + textRectOffset, y: 0, width: self.frame.width - textRectOffset, height: self.frame.height)
    }
 
}
