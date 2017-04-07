//
//  VideoViewController.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 4/7/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MediaPlayerLoader.shared.playerVC.view.removeFromSuperview()
        MediaPlayerLoader.shared.playerVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(MediaPlayerLoader.shared.playerVC.view)
        
        
        let views : [String : UIView] = [
            "playerVC" : MediaPlayerLoader.shared.playerVC.view
        ]
        
        let csPlayerVertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[playerVC]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        let csPlayerHorizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[playerVC]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        NSLayoutConstraint.activate(csPlayerHorizontal+csPlayerVertical)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MediaPlayerLoader.shared.playerVC.loadResource(urlString: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
    }
    
    deinit {
        
        MediaPlayerLoader.shared.playerVC.stop()
        MediaPlayerLoader.shared.playerVC.view.removeFromSuperview()
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
