//
//  MediaPlayerLoader.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 4/7/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

struct MediaPlayerLoader {
    
    var playerVC : NCTPlayerViewController
    private init() {
        self.playerVC = NCTPlayerViewController(nibName: "NCTPlayerViewController", bundle: nil)
    }
    
    static let shared = MediaPlayerLoader()
}
