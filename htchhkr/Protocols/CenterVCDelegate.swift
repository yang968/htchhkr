//
//  CenterVCDelegate.swift
//  htchhkr
//
//  Created by Spencer Yang on 1/2/18.
//  Copyright © 2018 Seungho Yang. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
