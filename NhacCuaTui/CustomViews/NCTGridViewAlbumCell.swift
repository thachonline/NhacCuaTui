//
//  NCTGridViewAlbumCell.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/30/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class NCTGridViewAlbumCell: UICollectionViewCell {
    @IBOutlet weak var topGradientView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var imgThump: UIImageView!
    
    @IBOutlet weak var lblViews: UILabel!
    
    @IBOutlet weak var lblAlbumName: UILabel!
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        //25 31 39
        let gradientLayerTop = CAGradientLayer()
        let color1 = UIColor(colorLiteralRed: 25.0/255.0, green: 31.0/255.0, blue: 39.0/255.0, alpha: 0.8).cgColor
        let color2 = UIColor(colorLiteralRed: 25.0/255.0, green: 31.0/255.0, blue: 39.0/255.0, alpha: 0.5).cgColor
        let color3 = UIColor(colorLiteralRed: 25.0/255.0, green: 31.0/255.0, blue: 39.0/255.0, alpha: 0.2).cgColor
        let color4 = UIColor(colorLiteralRed: 25.0/255.0, green: 31.0/255.0, blue: 39.0/255.0, alpha: 0.0).cgColor
        let color5 = UIColor(colorLiteralRed: 25.0/255.0, green: 31.0/255.0, blue: 39.0/255.0, alpha: 0.0).cgColor
        let color6 = UIColor(colorLiteralRed: 25.0/255.0, green: 31.0/255.0, blue: 39.0/255.0, alpha: 0.0).cgColor
        
        gradientLayerTop.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayerTop.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayerTop.colors = [color1, color2, color3, color4, color5 , color6]
        gradientLayerTop.bounds = self.topGradientView.bounds
        gradientLayerTop.anchorPoint = CGPoint.zero
        self.topGradientView.layer.insertSublayer(gradientLayerTop, at: 0)
  
    }
    
    func setAlbum(album : Playlist?) {
        if let al = album {
                self.lblViews.text = "\(al.plays)"
                self.lblAlbumName.text = al.playlistTitle
            
            let imgURL = al.playlistImage.replacingOccurrences(of: ".jpg", with: "_500.jpg")
            
            self.imgThump.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "TempAlbum"), options: .refreshCached)
        }
    }
    
}
