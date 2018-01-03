//
//  UIViewExt.swift
//  htchhkr
//
//  Created by Spencer Yang on 1/2/18.
//  Copyright © 2018 Seungho Yang. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(alpha: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
}
