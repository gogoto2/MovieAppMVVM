//
//  MovieCVTypeTwo.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 26/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class MovieCVCellTypeTwo: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var imgStarRating: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    
    func refreshData(movie: MovieResults) {
        
        self.lblMovieName.text = movie.title
        self.lblRating.text = String(movie.voteAverage)
        self.lblReleaseDate.text = dateFormatChange(yourdate: movie.releaseDate, currentFormat: "yyyy-MM-dd", requiredFormat: "dd MMM, yyyy")
        let imgURL = GlobalConstants.poster_image_path + movie.posterPath
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
