//
//  CollectionViewInsideTableViewCell.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 30/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class CollectionViewInsideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "GenreCVCell", bundle: nil), forCellWithReuseIdentifier: "GenreCVCell")
            collectionView.register(UINib(nibName: "MovieCVCellTypeOne", bundle: nil), forCellWithReuseIdentifier: "MovieCVCellTypeOne")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
