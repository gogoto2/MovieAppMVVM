//
//  CastCVCell.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class CastCVCell: UICollectionViewCell {

    @IBOutlet weak var viewCard: CardView!
    @IBOutlet weak var imgCast: UIImageView!
    @IBOutlet weak var lblCastOrigionalName: UILabel!
    @IBOutlet weak var lblCastName: UILabel!
    
    func refreshData(credits: CastResults) {
        
        self.lblCastOrigionalName.text = credits.name
        self.lblCastName.text = credits.character
        
        if credits.profilePath != nil {
            let imgURL = GlobalConstants.poster_image_path + credits.profilePath!
            self.imgCast.sd_setShowActivityIndicatorView(true)
            self.imgCast.sd_setIndicatorStyle(.gray)
            self.imgCast.sd_setImage(with: URL(string: imgURL), placeholderImage: #imageLiteral(resourceName: "default-person"), options:.refreshCached)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //self.imgCast.roundCorners([.topLeft, .topRight], radius: 5.0)
    }
}
