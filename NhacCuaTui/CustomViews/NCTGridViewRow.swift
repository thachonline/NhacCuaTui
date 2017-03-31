//
//  NCTGridViewRow.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/29/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class NCTGridViewRow: UITableViewCell , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate : NCTGridViewRowDelegate?
    var rowSection : Int = -1
    
    func  reloadData() {
        self.collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        if let identifers = self.delegate?.nctGridViewRowCellReuseIdentifiers(for: IndexPath(row: 0
            , section: self.rowSection )) {
        self.collectionView.register(UINib(nibName: identifers.nib, bundle: nil), forCellWithReuseIdentifier: identifers.identifier)
        }
    }

    //MARK: -CollectionView
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let del = self.delegate else {
            return UICollectionViewCell()
        }
        
        let identifers = del.nctGridViewRowCellReuseIdentifiers(for: IndexPath(row: indexPath.row
            , section: self.rowSection ))
        
        if let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: identifers.identifier, for: indexPath) {
            return cell
        }
        
        
        return NCTGridViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = self.delegate?.nctGridViewRow(self, numberOfItemsIn: self.rowSection) else {
            return 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let size = self.delegate?.nctGridViewRow(self, sizeForItemAt: IndexPath(row: indexPath.row
            , section: self.rowSection )) else {
            return CGSize(width: 0, height: 0)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.nctGridViewRow(self, didSelectItemAt: IndexPath(row: indexPath.row
            , section: self.rowSection ))
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.nctGridViewRow(self, willDisplayCell: cell, atIndexPath: IndexPath(row: indexPath.row
            , section: self.rowSection ))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 150, 0, 150)
    }

    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if context.nextFocusedIndexPath != nil && !collectionView.isScrollEnabled {
            self.collectionView.scrollToItem(at: context.nextFocusedIndexPath!, at: .centeredHorizontally, animated: true)
        }
        
        if let nextIndexPath = context.nextFocusedIndexPath {
            if let cell = collectionView.cellForItem(at: nextIndexPath){
                self.delegate?.nctGridViewRow(self, nextFocused: cell)
            }
        }
        
        if let prevIndexPath = context.previouslyFocusedIndexPath {
            if let cell = collectionView.cellForItem(at: prevIndexPath){
                self.delegate?.nctGridViewRow(self, previouslyFocused: cell)
            }
        }
        
    }

}


protocol NCTGridViewRowDelegate:class {
    func nctGridViewRowCellReuseIdentifiers(for indexPath : IndexPath) -> (nib: String, identifier: String)
    func nctGridViewRow(_ nctGridViewRow : NCTGridViewRow , numberOfItemsIn section : Int) -> Int
    func nctGridViewRow(_ nctGridViewRow : NCTGridViewRow , sizeForItemAt indexPath: IndexPath) -> CGSize
    
    func nctGridViewRow(_ nctGridViewRow: NCTGridViewRow, didSelectItemAt indexPath: IndexPath)
    func nctGridViewRow(_ nctGridViewRow: NCTGridViewRow, willDisplayCell cell : UICollectionViewCell , atIndexPath indexPath : IndexPath)
    
    func nctGridViewRow(_ nctGridViewRow: NCTGridViewRow, previouslyFocused cell: UICollectionViewCell?)
    func nctGridViewRow(_ nctGridViewRow: NCTGridViewRow, nextFocused cell: UICollectionViewCell?)
}
