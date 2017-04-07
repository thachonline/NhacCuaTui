//
//  MainViewController.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/28/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit



class MainViewController: NCTBaseViewController, NCTBaseViewControllerDelegate {
    @IBOutlet weak var menuDrawerHandler: UIView!
    
    @IBOutlet weak var menuDrawer: UIView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var drawerHandlerTrigger: FocusableView!
    
    lazy var homeVC : HomeViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: idHomeViewController) as! HomeViewController
    }()

    @IBOutlet var menuButtons : [NCTMenuButton]!
    //default 500
    @IBOutlet weak var csMenuDrawerLead: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prevent menu from toggling in on first load
        self.drawerHandlerTrigger.isUserInteractionEnabled = false
        self.contentView.addSubview(self.homeVC.view)
        self.homeVC.view.didMoveToSuperview()
        self.homeVC.baseDelegate = self
        
        
    }

    func toggleDrawerMenu(toggleIn : Bool) {
        self.menuDrawer.isUserInteractionEnabled = false
        self.menuDrawerHandler.isUserInteractionEnabled = false
        self.menuDrawer.isHidden = false
        self.csMenuDrawerLead.constant = toggleIn ? 0 : -512
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
            
            
        }) { (completed) in
            if completed {
            self.view.layoutIfNeeded()
                self.menuDrawer.isUserInteractionEnabled = true
                self.menuDrawerHandler.isUserInteractionEnabled = true
                if toggleIn == false {
                    self.menuDrawer.isHidden = true
                    
                }
                else {
                    self.viewToFocus = self.menuButtons.first
                }
                
                
                
                self.menuDrawerHandler.isHidden = toggleIn
            }
        }
    }
    
    // MARK: -RC events
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard let  type = presses.first?.type else {
            return
        }
        
        switch type {
        case .menu:
            print("menu pressed")
        case .playPause:
            print("play/pause pressed")
        default:
            break
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedItem === self.drawerHandlerTrigger {
            self.toggleDrawerMenu(toggleIn: true)
        }
        
        //close menu when menu btn lost focus
        if !(context.nextFocusedItem is NCTMenuButton) && context.previouslyFocusedItem is NCTMenuButton && self.csMenuDrawerLead.constant == 0 {
            self.toggleDrawerMenu(toggleIn: false)
        }
    }
    
    //NCTBaseViewControllerDelegate
    func requestToFocus(view: UIView) {
        self.viewToFocus = view
        
        //prevent menu from toggling in on the first load
        let deadlineTime = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.drawerHandlerTrigger.isUserInteractionEnabled = true
        }
    }
    
    

}
