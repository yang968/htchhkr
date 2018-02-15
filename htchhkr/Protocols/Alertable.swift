//
//  Alertable.swift
//  htchhkr
//
//  Created by Spencer Yang on 2/14/18.
//  Copyright © 2018 Seungho Yang. All rights reserved.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    func showAlert(_ message: String) {
        print("Alert: " + message)
        let alertController = UIAlertController(title: "Error:", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}
