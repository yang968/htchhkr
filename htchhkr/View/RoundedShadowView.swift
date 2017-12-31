//
//  RoundedShadowView.swift
//  htchhkr
//
//  Created by Spencer Yang on 12/31/17.
//  Copyright © 2017 Seungho Yang. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {

    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = 5.0
        
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
