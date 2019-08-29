//
//  MovieDetailVC.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MovieDetailVC: ButtonBarPagerTabStripViewController {
    
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
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let aboutVC = AboutVC(nibName: "AboutVC", bundle: nil)
        let castVC = CastVC(nibName: "CastVC", bundle: nil)
        let reviewsVC = ReviewsVC(nibName: "ReviewsVC", bundle: nil)
        let trailersVC = TrailersVC(nibName: "TrailersVC", bundle: nil)
        
        return [aboutVC, castVC, reviewsVC, trailersVC]
    }
}
