//
//  ContainerVC.swift
//  htchhkr
//
//  Created by Spencer Yang on 1/1/18.
//  Copyright © 2018 Seungho Yang. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}

enum ShowWhichVC {
    case homeVC
}

var showVC: ShowWhichVC = .homeVC

class ContainerVC: UIViewController {
    
    var homeVC : HomeVC!
    var leftVC : LeftSidePanelVC!
    var centerController : UIViewController!
    var currentState : SlideOutState = .collapsed
    
    var statusBarIsHidden = false
    var centerPanelExpandedOffset : CGFloat!

    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerPanelExpandedOffset = self.view.frame.width * 0.7
        initCenter(screen: showVC)
    }

    func initCenter(screen: ShowWhichVC) {
        var presentingController : UIViewController
        showVC = screen
        
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
        
        presentingController = homeVC
        
        if let con = centerController {
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }
        
        centerController = presentingController
        view.addSubview(centerController.view)
        centerController.didMove(toParentViewController: self)
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarIsHidden
    }
}

fileprivate extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func leftViewController() -> LeftSidePanelVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelVC
    }
    
    class func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}

extension ContainerVC : CenterVCDelegate {
    // Expand or Close Left Panel
    func toggleLeftPanel() {
        let notExpanded = (currentState != .leftPanelExpanded)
        
        if notExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notExpanded)
    }
    
    func addLeftPanelViewController() {
        if leftVC == nil {
            leftVC = UIStoryboard.leftViewController()
            addChildSidePanelViewController(leftVC)
        }
    }
    
    func addChildSidePanelViewController(_ sidePanelController: LeftSidePanelVC) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            statusBarIsHidden = !statusBarIsHidden
            animateStatusBar()
            setupWhiteCoverView()
            currentState = .leftPanelExpanded
            
            animateCenterPanelByX(x: centerPanelExpandedOffset)
        } else {
            statusBarIsHidden = !statusBarIsHidden
            animateStatusBar()
            hideWhiteCoverView()
            currentState = .collapsed
            animateCenterPanelByX(x: 0, completion: { (success) in
                if success {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            })
        }
    }
    
    func animateCenterPanelByX(x : CGFloat, completion: ((Bool)->())! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = x
        }, completion: completion)
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
    func setupWhiteCoverView() {
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 25
        
        self.centerController.view.addSubview(whiteCoverView)
        whiteCoverView.fadeTo(alpha: 0.75, duration: 0.2)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        
        self.centerController.view.addGestureRecognizer(tap)
        showShadowForCenterViewController(status: true)
    }
    
    func showShadowForCenterViewController(status: Bool) {
        if status {
            centerController.view.layer.shadowOpacity = 0.6
        } else {
            centerController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func hideWhiteCoverView() {
        showShadowForCenterViewController(status: false)
        centerController.view.removeGestureRecognizer(tap)
        for subview in self.centerController.view.subviews {
            if subview.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }, completion: { (finished) in
                    if finished {
                        subview.removeFromSuperview()
                    }
                })
            }
        }
    }
}






