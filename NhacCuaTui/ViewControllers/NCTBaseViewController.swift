//
//  NCTBaseViewController.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/28/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit
protocol NCTBaseViewControllerDelegate : class {
    func requestToFocus(view : UIView)
}
class NCTBaseViewController: UIViewController {

    weak var baseDelegate : NCTBaseViewControllerDelegate?
    weak var viewToFocus: UIView? = nil {
        didSet {
            if viewToFocus != nil {
                let deadlineTime = DispatchTime.now() + 0.1
                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                    self.setNeedsFocusUpdate();
                    self.updateFocusIfNeeded();
                }
                
            }
        }
    }
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        if viewToFocus != nil {
            return [viewToFocus!];
        } else {
            return [];
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
