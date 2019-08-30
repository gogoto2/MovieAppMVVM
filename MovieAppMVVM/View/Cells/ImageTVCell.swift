//
//  ImageTVCell.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 30/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class ImageTVCell: UITableViewCell {
    
    @IBOutlet weak var imgMoviePoster: UIImageView!
    
    func refreshData(movieDetails: MovieDetails) {
        
        if movieDetails.posterPath != "" {
            let imgURL = GlobalConstants.poster_image_path + movieDetails.backdropPath
            self.imgMoviePoster.sd_setShowActivityIndicatorView(true)
            self.imgMoviePoster.sd_setIndicatorStyle(.gray)
            self.imgMoviePoster.sd_setImage(with: URL(string: imgURL), placeholderImage: #imageLiteral(resourceName: "cinema"), options:.refreshCached)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imgMoviePoster.layer.cornerRadius = 5.0
        self.imgMoviePoster.clipsToBounds = true
    }
}
