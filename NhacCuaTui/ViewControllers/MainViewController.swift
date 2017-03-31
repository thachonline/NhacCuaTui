//
//  MainViewController.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/28/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class MainViewController: NCTBaseViewController {
    @IBOutlet weak var menuDrawerHandler: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return self.contentView.subviews
    }
    
    lazy var homeVC : HomeViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: idHomeViewController) as! HomeViewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.contentView.addSubview(self.homeVC.view)
        self.homeVC.view.didMoveToSuperview()
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
        
    }

}
