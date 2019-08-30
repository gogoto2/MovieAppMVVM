//
//  MovieCVCellTypeOne.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 23/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCVCellTypeOne: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var imgStarRating: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    
    func refreshData(movie: MovieResults) {
        
        self.lblMovieName.text = movie.title
        self.lblRating.text = String(movie.voteAverage)
        
        let imgURL = GlobalConstants.poster_image_path + movie.posterPath!
        self.imgMovie.sd_setShowActivityIndicatorView(true)
        self.imgMovie.sd_setIndicatorStyle(.gray)
        self.imgMovie.sd_setImage(with: URL(string: imgURL), placeholderImage: #imageLiteral(resourceName: "cinema"), options:.refreshCached)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainView.layer.cornerRadius = 5.0
        self.mainView.clipsToBounds = true
        
        self.imgMovie.layer.cornerRadius = 5.0
        self.imgMovie.clipsToBounds = true
    }
}
