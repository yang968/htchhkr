//
//  RoundImageView.swift
//  htchhkr
//
//  Created by Spencer Yang on 12/30/17.
//  Copyright © 2017 Seungho Yang. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        // Cookie Cut the image to the image view
        self.clipsToBounds = true
    }

}
