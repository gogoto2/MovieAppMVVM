//
//  MovieDetailVC.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import NotificationBannerSwift

class MovieDetailVC: ButtonBarPagerTabStripViewController {
    
    var movieResult: MovieResults?
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = UIColor(hex: "262626")
        settings.style.buttonBarItemBackgroundColor = UIColor(hex: "262626")
        settings.style.selectedBarBackgroundColor = UIColor.themeCherry
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.lightGray
            newCell?.label.textColor = UIColor.white
        }
        
        self.navigationItem.title = "Movie Details"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if self.isFavouriteMovie(id: Int(SharedInstance.sharedInstance.movieId) ?? 0) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favourite-white"), style: .plain, target: self, action: #selector(handleFavourite))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favourite"), style: .plain, target: self, action: #selector(handleFavourite))
        }
        
        super.viewDidLoad()
    }
    
    func isFavouriteMovie(id: Int) -> Bool {
        let arrMovie = CoreDataManager.shared.fetchFavouriteMovies()
        var value = false
        for each in arrMovie {
            if each.id == id {
                value = true
                break
            }
            value = false
        }
        return value
    }
    
    @objc func handleFavourite() {
        
        if self.isFavouriteMovie(id: Int(SharedInstance.sharedInstance.movieId) ?? 0) {
            CoreDataManager.shared.deleteMovie(id: Int64(SharedInstance.sharedInstance.movieId) ?? 0)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favourite"), style: .plain, target: self, action: #selector(handleFavourite))
            NotificationBanner(title: "Success!", subtitle: "This movie is removed from your favourite list.", style: .success).show()
        } else {
            CoreDataManager.shared.addFavouriteMovies(voteCount: self.movieResult!.voteCount, id: self.movieResult!.id, video: self.movieResult!.video, voteAverage: self.movieResult!.voteAverage, title: self.movieResult!.title, popularity: self.movieResult!.popularity, posterPath: (self.movieResult?.posterPath)!, originalLanguage: self.movieResult!.originalLanguage, originalTitle: self.movieResult!.originalTitle, backdropPath: (self.movieResult?.backdropPath)!, adult: self.movieResult!.adult, overview: self.movieResult!.overview, releaseDate: (self.movieResult?.releaseDate)!)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favourite-white"), style: .plain, target: self, action: #selector(handleFavourite))
            NotificationBanner(title: "Success!", subtitle: "This movie is added to your favourite list.", style: .success).show()
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let aboutVC = AboutVC(nibName: "AboutVC", bundle: nil)
        let reviewsVC = ReviewsVC(nibName: "ReviewsVC", bundle: nil)
        let trailersVC = TrailersVC(nibName: "TrailersVC", bundle: nil)
        
        return [aboutVC, reviewsVC, trailersVC]
    }
}
