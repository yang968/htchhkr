//
//  LoginVC.swift
//  htchhkr
//
//  Created by Spencer Yang on 1/2/18.
//  Copyright © 2018 Seungho Yang. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: RoundedTextField!
    @IBOutlet weak var passwordField: RoundedTextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var authButton: RoundedShadowButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self

        view.bindKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }

    // Hides keyboard when finished editing
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func authButtonPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            authButton.animateButton(shouldLoad: true, withMessage: nil)
            self.view.endEditing(true)
            
            // Login / Sign up a user
            if let email = emailField.text, let password = passwordField.text {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {
                        if let user = user {
                            // user is passenger
                            if self.segmentControl.selectedSegmentIndex == 0 {
                                let userData = ["provider": user.providerID] as [String: Any]
                                
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                            }
                            // user is driver
                            else {
                                let userData = ["provider" : user.providerID,
                                                "userIsDriver" : true,
                                                "isPickUpModeEnabled" : false,
                                                "driverIsOnTrip" : false
                                ] as [String:Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                            }
                        }
                        print("Email user authenticated successfully with Firebase")
                    }
                    // User does not exist or wrong password was entered and returns an error
                    else {
                        if let errorCode = AuthErrorCode(rawValue: error!._code) {
                            switch errorCode {
                            case .wrongPassword :
                                print("Incorrect Password. Please try again")
                            default :
                                print("Unexpected Error Occurred. Please try again")
                            }
                        }
                        
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                    switch errorCode {
                                    case .invalidEmail :
                                        print("Invalid Email. Please try again")
                                    default :
                                        print("Unexpected Error Occurred. Please try again")
                                    }
                                }
                            }
                            else {
                                if let user = user {
                                    if self.segmentControl.selectedSegmentIndex == 0 {
                                        let userData = ["provider" : user.providerID] as [String:Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                                    } else {
                                        let userData = ["provider" : user.providerID,
                                                        "userIsDriver" : true,
                                                        "isPickUpModeEnabled" : false,
                                                        "driverIsOnTrip" : false
                                            ] as [String:Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                                    }
                                }
                                print("Successfully created a new user")
                            }
                        })
                    }
                })
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
