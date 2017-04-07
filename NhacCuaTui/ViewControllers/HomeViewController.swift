//
//  HomeViewController.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/27/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: NCTBaseViewController, NCTGridViewDelegate{

    @IBOutlet weak var gridHome: NCTGridView!
    var homeData:(mvs : [Video],clips : [Video], albums : [Playlist], karaoke : [Video] ) = (mvs : [],clips : [], albums : [], karaoke : [] )
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.gridHome.delegate  = self
        ApiConnector.shared.getHomeData(completionBlock: { [unowned self] (homeData) in
            self.homeData = homeData
            self.gridHome.reloadData()
            self.baseDelegate?.requestToFocus(view: self.gridHome.tableView)
        }) { (errorCode) in
            print(errorCode ?? -1)
        }
        
    }
    

    


  
    //MARK: -NCTGridViewDelegate
    
    func nctGridViewCellReuseIdentifiers(for indexPath: IndexPath) -> (nib: String, identifier: String) {
        if indexPath.section == 2 {
            return (idNCTGridViewAlbumCell, idNCTGridViewAlbumCell)
        }
        
        
        return (idNCTGridViewCell, idNCTGridViewCell)
    }
    
    func nctGridView(_ nctTableView: NCTGridView, heightForSection section: Int) -> CGFloat {
        
        if section == 2 {
            return 500
        }
        
        return 400
    }
    
    func nctGridView(_ nctTableView: NCTGridView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return self.homeData.mvs.count
        case 1 :
            return self.homeData.clips.count
        case 2 :
            return self.homeData.albums.count
        case 3 :
            return self.homeData.karaoke.count
        default:
            return 0
        }
    }
    
    func nctGridView(_ nctGridView: NCTGridView, didSelectItemAtIndexPath indexPath: IndexPath) {
        switch indexPath.section {
        case 0,1,3:
            if let videoVC = self.storyboard?.instantiateViewController(withIdentifier: idVideoViewController) as? VideoViewController {
                mRootVC?.present(videoVC, animated: true, completion: nil)
            }
            break
        case 2:
            
            break
        default:
            break
        }
    }
    
    func nctGridView(_ nctGridView: NCTGridView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if indexPath.section == 2 {
           return CGSize(width: 400, height: 500)
        }
        return CGSize(width: 500, height: 400)
    }
    
    func nctGridView(_ nctGridView: NCTGridView, willDisplayCell cell: UICollectionViewCell, atIndexPath indexPath: IndexPath) {
        if cell is NCTGridViewCell {
            let gridCell = cell as! NCTGridViewCell
            switch indexPath.section {
            case 0:
                gridCell.setVideo(video: self.homeData.mvs[indexPath.row])
                break
            case 1:
                gridCell.setVideo(video: self.homeData.clips[indexPath.row])
                break
            case 3:
                gridCell.setVideo(video: self.homeData.karaoke[indexPath.row])
                break
            default:
                break
            }
        }
        
        if cell is NCTGridViewAlbumCell && indexPath.section == 2{
            let gridCell = cell as! NCTGridViewAlbumCell
            gridCell.setAlbum(album: self.homeData.albums[indexPath.row])
        }
    }
    
    func numberOfSections(nctGridView: NCTGridView) -> Int {
        return 5
    }
    
    func nctGridView(_ nctGridView: NCTGridView, titleForHeaderIn section: Int) -> String {
        switch section {
        case 0:
            return "Video Hot"
        case 1 :
            return "Giải Trí"
        case 2 :
            return "Album Hot"
        case 3 :
            return "Karaoke"
        default:
            return ""
        }
    }
    
    func nctGridView(_ nctGridView: NCTGridView, nextFocused cell: UICollectionViewCell?) {
        if let theCell = cell as? NCTGridViewCell{
            theCell.containerView.layer.shadowColor = UIColor.white.cgColor
            theCell.containerView.layer.shadowRadius = 20.0
            theCell.containerView.layer.shadowOpacity = 1.0
            UIView.animate(withDuration: 0.2, animations: {
                theCell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
               
            })
        }
        
        if let theAlbumCell = cell as? NCTGridViewAlbumCell{
            theAlbumCell.containerView.layer.shadowColor = UIColor.white.cgColor
            theAlbumCell.containerView.layer.shadowRadius = 20.0
            theAlbumCell.containerView.layer.shadowOpacity = 1.0
            UIView.animate(withDuration: 0.2, animations: {
                theAlbumCell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            })
        }
    }
    
    func nctGridView(_ nctGridView: NCTGridView, previouslyFocused cell: UICollectionViewCell?) {
        if let theCell = cell as? NCTGridViewCell{
            theCell.containerView.layer.shadowColor = UIColor.clear.cgColor
            theCell.containerView.layer.shadowRadius = 0.0
            theCell.containerView.layer.shadowOpacity = 0.0
            UIView.animate(withDuration: 0.2, animations: {
                theCell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
         
            })
        }
        
        if let theAlbumCell = cell as? NCTGridViewAlbumCell{
            theAlbumCell.containerView.layer.shadowColor = UIColor.clear.cgColor
            theAlbumCell.containerView.layer.shadowRadius = 0.0
            theAlbumCell.containerView.layer.shadowOpacity = 0.0
            UIView.animate(withDuration: 0.2, animations: {
                theAlbumCell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
    }
   
}
