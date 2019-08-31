//
//  TitleAndValueTVCell.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 30/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class TitleAndValueTVCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var imgStar: UIImageView!
    
    func refreshDataForDate(movieDetails: MovieDetails) {
        
        self.imgStar.isHidden = true
        self.lblTitle.text = "Release Date"
        
        if movieDetails.releaseDate != "" {
            self.lblValue.text = dateFormatChange(yourdate: movieDetails.releaseDate, currentFormat: "yyyy-MM-dd", requiredFormat: "dd MMM, yyyy")
        } else {
            self.lblValue.text = "-"
        }
    }
    
    func refreshDataForRating(movieDetails: MovieDetails) {
        
        self.lblTitle.text = "Ratings"
        self.lblValue.text = String(movieDetails.voteAverage)
    }
}
