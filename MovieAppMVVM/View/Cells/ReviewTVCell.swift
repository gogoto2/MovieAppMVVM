//
//  ReviewTVCell.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class ReviewTVCell: UITableViewCell {

    @IBOutlet weak var lblNameFirstLetter: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    
    func refreshData(review: ReviewResults) {

        self.lblAuthorName.text = review.author.capitalizingFirstLetter()

        let str = review.author
        let index = str.index(str.startIndex, offsetBy: 0)
        self.lblNameFirstLetter.text = String(str[index]).capitalizingFirstLetter()

        self.lblReview.text = review.content
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.lblNameFirstLetter.layer.cornerRadius = self.lblNameFirstLetter.frame.height/2
        self.lblNameFirstLetter.layer.masksToBounds = true
        self.lblNameFirstLetter.layer.borderColor = UIColor.white.cgColor
        self.lblNameFirstLetter.layer.borderWidth = 1.0
    }
}
