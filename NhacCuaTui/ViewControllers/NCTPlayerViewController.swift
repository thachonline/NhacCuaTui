//
//  NCTPlayerViewController.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 4/5/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit
import AVKit
class NCTPlayerViewController: UIViewController {
    
    
    var player : AVPlayer?
    var playerItem : AVPlayerItem?
    
    
    lazy var playerLayer : AVPlayerLayer = {
        let playerLayer = AVPlayerLayer()
        playerLayer.frame = self.view.bounds
        return playerLayer
    } ()
    
    @IBOutlet weak var playerContainer: UIView!
    
    @IBOutlet weak var playerControls: UIView!
    
    @IBOutlet weak var bgCover: UIImageView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.playerLayer.frame = self.view.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.playerContainer.layer.addSublayer(self.playerLayer)
        
        
    }
    
    func loadResource(urlString : String) {
        if let vUrl = URL(string: urlString) {
            self.playerItem = AVPlayerItem(url: vUrl)
            self.player = AVPlayer(playerItem: self.playerItem)
            self.playerLayer.player = self.player
        }
        self.player?.play()
    }
    
    func stop() {
        self.player?.pause()
        self.player?.seek(to: kCMTimeZero)
    }


    



}
