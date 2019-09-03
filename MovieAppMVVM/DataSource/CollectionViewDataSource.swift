//
//  CollectionViewDataSource.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 04/09/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSource<CellType, ViewModel>: NSObject, UICollectionViewDataSource where CellType: UICollectionViewCell {
    
    let cellIdentifier: String
    var items: [ViewModel]
    let configureCell: (CellType, ViewModel) -> ()
    
    init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping(CellType, ViewModel) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func updateItems(_ items: [ViewModel]) {
        self.items = items
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
        if self.items.count > 0 {
            numOfSections            = 1
            collectionView.backgroundView = nil
        } else {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
            noDataLabel.text          = "No Records"
            noDataLabel.textColor     = UIColor.lightGray
            noDataLabel.textAlignment = .center
            collectionView.backgroundView  = noDataLabel
        }
        return numOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Cell with identifier \(self.cellIdentifier) not found.")
        }
        let vm = self.items[indexPath.row]
        self.configureCell(cell, vm)
        return cell
    }
}
