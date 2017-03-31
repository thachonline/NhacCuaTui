//
//  NCTGridView.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/29/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class NCTGridView: UIView , UITableViewDataSource, UITableViewDelegate , NCTGridViewRowDelegate{

    private let rowReuseIdentifier = "NCTGridViewRow"
    

    
    private var tableView : UITableView
    weak var delegate : NCTGridViewDelegate?
    override init(frame: CGRect) {
        self.tableView = UITableView(frame: frame)
        super.init(frame: frame)
        self.tableView.register(UINib(nibName: rowReuseIdentifier, bundle: nil), forCellReuseIdentifier: rowReuseIdentifier)
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "TblHeader")
        self.addSubview(tableView)
        self.tableView.isScrollEnabled = false
        self.tableView.dataSource = self
        self.tableView.delegate = self

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.tableView = UITableView()
        super.init(coder: aDecoder)
        self.tableView.register(UINib(nibName: rowReuseIdentifier, bundle: nil), forCellReuseIdentifier: rowReuseIdentifier)
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "TblHeader")
        self.addSubview(tableView)
        self.tableView.isScrollEnabled = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.tableView.frame = self.frame
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0)
        
    }
    
    
    //MARK: - TABLEVIEW
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create the header view
        let headerView =  UIView.init(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 100))
        headerView.backgroundColor = UIColor.clear
        
        // Create the Label
        let label: UILabel? = UILabel(frame: CGRect(x: 200, y: 0, width: self.tableView.frame.size.width, height: 100))
        label!.textAlignment = .left
        label!.text = self.delegate?.nctGridView(self, titleForHeaderIn: section)
        
        // Add the label to your headerview
        headerView.addSubview(label!)
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let height = self.delegate?.nctGridView(self, heightForSection: indexPath.section)  else{
            return 100
        }
        
        if let size = self.delegate?.nctGridView(self, sizeForItemAtIndexPath: indexPath)  {
            if size.height >= height {
                return size.height + 10.0
            }
        }
        
        return height
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: rowReuseIdentifier) as? NCTGridViewRow else {
            return NCTGridViewRow()
        }
        
        cell.rowSection = indexPath.section
        cell.delegate = self
        cell.reloadData()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = self.delegate?.numberOfSections(nctGridView: self) else {
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedIndexPath != nil && !tableView.isScrollEnabled {
            self.tableView.scrollToRow(at: context.nextFocusedIndexPath!, at: .middle, animated: true)
        }
    }
    
    //MARK: -NCTGridViewRowDelegate
    
    func nctGridViewRow(_ nctGridViewRow: NCTGridViewRow, nextFocused cell: UICollectionViewCell?) {
        self.delegate?.nctGridView(self, nextFocused: cell)
    }
    
    func nctGridViewRow(_ nctGridViewRow: NCTGridViewRow, previouslyFocused cell: UICollectionViewCell?) {
        self.delegate?.nctGridView(self, previouslyFocused: cell)
    }
    
    func nctGridViewRowCellReuseIdentifiers(for indexPath:IndexPath) -> (nib: String, identifier: String) {
        
        if let res = self.delegate?.nctGridViewCellReuseIdentifiers(for: indexPath) {
            return res
        }
        return ("","")
    }
    
    func nctGridViewRow(_ nctGridViewRow: NCTGridViewRow, numberOfItemsIn section: Int) -> Int {
        if let res = self.delegate?.nctGridView(self, numberOfItemsInSection: section) {
            return res
        }
        
        return 0
    }
    
    func nctGridViewRow(_ nctGridViewRow: NCTGridViewRow, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.nctGridView(self, didSelectItemAtIndexPath: indexPath)
    }
    
    func nctGridViewRow(_ nctGridViewRow: NCTGridViewRow, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let res = self.delegate?.nctGridView(self, sizeForItemAtIndexPath: indexPath) {
            return res
        }
        return CGSize(width: 100, height: 100)
    }
    
    func nctGridViewRow(_ nctGridViewRow: NCTGridViewRow, willDisplayCell cell: UICollectionViewCell, atIndexPath indexPath: IndexPath) {
        self.delegate?.nctGridView(self, willDisplayCell: cell, atIndexPath: indexPath)
    }
}

protocol NCTGridViewDelegate:class {
    
    func nctGridView(_ nctGridView: NCTGridView, didSelectItemAtIndexPath indexPath: IndexPath)
    
    func nctGridView(_ nctGridView: NCTGridView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    
    func nctGridViewCellReuseIdentifiers(for indexPath:IndexPath) -> (nib: String, identifier: String)
    
    func nctGridView(_ nctTableView: NCTGridView, heightForSection section: Int) -> CGFloat
    
    func nctGridView(_ nctTableView: NCTGridView, numberOfItemsInSection section: Int) -> Int
    
    func numberOfSections(nctGridView : NCTGridView) -> Int
    
    func nctGridView(_ nctGridView: NCTGridView, willDisplayCell cell: UICollectionViewCell, atIndexPath indexPath: IndexPath)
    func nctGridView(_ nctGridView: NCTGridView, titleForHeaderIn section:Int) -> String
    
    func nctGridView(_ nctGridView: NCTGridView, nextFocused cell: UICollectionViewCell?)
    
    func nctGridView(_ nctGridView: NCTGridView, previouslyFocused cell: UICollectionViewCell?)
}
