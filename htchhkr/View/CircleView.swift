//
//  CircleView.swift
//  htchhkr
//
//  Created by Spencer Yang on 12/31/17.
//  Copyright © 2017 Seungho Yang. All rights reserved.
//

import UIKit

class CircleView: UIView {

    override func awakeFromNib() {
        setupView()
    }

    @IBInspectable var borderColor : UIColor? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
    }
}
