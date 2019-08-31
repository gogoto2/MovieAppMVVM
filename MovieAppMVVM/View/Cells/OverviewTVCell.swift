//
//  OverviewTVCell.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 30/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class OverviewTVCell: UITableViewCell {

    @IBOutlet weak var lblOverviewTitle: UILabel!
    @IBOutlet weak var lblOverviewValue: UILabel!
    
    func refreshData(movieDetails: MovieDetails) {
        
        self.lblOverviewTitle.text = "Overview"
        self.lblOverviewValue.text = movieDetails.overview
    }
}
