//
//  LeftSidePanelVC.swift
//  htchhkr
//
//  Created by Spencer Yang on 1/1/18.
//  Copyright © 2018 Seungho Yang. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {
    
    let appDelegate = AppDelegate.getAppDelegate()
    let currentUserId = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var loginOutButton: UIButton!
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var pickupModeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View Will Appear")
        pickupModeSwitch.isOn = false
        pickupModeSwitch.isHidden = true
        pickupModeLabel.isHidden = true
        
        observePassengersAndDrivers()
        
        if Auth.auth().currentUser == nil {
            userEmailLabel.text = ""
            accountTypeLabel.text = ""
            userImageView.isHidden = true
            loginOutButton.setTitle("Sign Up / Login", for: .normal)
        } else {
            userEmailLabel.text = Auth.auth().currentUser?.email
            //accountTypeLabel.text = ""
            userImageView.isHidden = false
            loginOutButton.setTitle("Logout", for: .normal)
        }
    }
    
    func observePassengersAndDrivers() {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
            // Get all the children and it's objects
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.accountTypeLabel.text = "PASSENGER"
                    }
                }
            }
        }
        
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.accountTypeLabel.text = "DRIVER"
                        self.pickupModeSwitch.isHidden = false
                        
                        let switchStatus = snap.childSnapshot(forPath: "isPickUpModeEnabled").value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
                        self.pickupModeLabel.isHidden = false
                    }
                }
            }
        }
        print(Auth.auth().currentUser)
    }

    @IBAction func signUpLoginButtonPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            present(loginVC!, animated: true, completion: nil)
        } else {
            do {
                try Auth.auth().signOut()
                userEmailLabel.text = ""
                accountTypeLabel.text = ""
                userImageView.isHidden = true
                pickupModeLabel.text = ""
                pickupModeSwitch.isHidden = true
                loginOutButton.setTitle("Sign Up / Login", for: .normal)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    @IBAction func switchToggled(_ sender: Any) {
        if pickupModeSwitch.isOn {
            pickupModeLabel.text = "PICKUP MODE ENABLED"
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickUpModeEnabled" : true])
        } else {
            pickupModeLabel.text = "PICKUP MODE DISABLED"
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickUpModeEnabled" : false])
        }
        appDelegate.MenuContainerVC.toggleLeftPanel()
    }
}
