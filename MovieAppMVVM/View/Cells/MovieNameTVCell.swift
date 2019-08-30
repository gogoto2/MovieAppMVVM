//
//  MovieNameTVCell.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 30/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class MovieNameTVCell: UITableViewCell {

    @IBOutlet weak var lblMovieName: UILabel!
    
    func refreshData(movieDetails: MovieDetails) {
        
        self.lblMovieName.text = movieDetails.title
    }
}
