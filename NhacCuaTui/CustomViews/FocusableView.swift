//
//  FocusableView.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/27/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class FocusableView: UIView {
    override var canBecomeFocused: Bool {
        return true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
    }

}
