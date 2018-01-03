//
//  GradientView.swift
//  htchhkr
//
//  Created by Spencer Yang on 12/30/17.
//  Copyright © 2017 Seungho Yang. All rights reserved.
//

import UIKit

class GradientView: UIView {

    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        setupGradientView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupGradientView() {
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        
        gradient.startPoint = CGPoint.zero
        // 1 = 100%
        gradient.endPoint = CGPoint(x: 0, y: 1)
        // White goes upto 80% of the view, while transparent white color goes up to 100%
        gradient.locations = [0.8, 1.0]
        self.layer.addSublayer(gradient)
        
        self.bringSubview(toFront: self.subviews.first!)
    }

}
