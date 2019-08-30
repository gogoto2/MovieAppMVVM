//
//  GenreCVCell.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 30/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class GenreCVCell: UICollectionViewCell {
    
    @IBOutlet weak var lblGenre: UILabel!
    
    func refreshData(genre: Genre) {
        self.lblGenre.text = genre.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
}
