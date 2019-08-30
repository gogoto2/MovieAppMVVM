//
//  ReviewsVC.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SVProgressHUD

class ReviewsVC: UIViewController {
    
    @IBOutlet weak var tableViewReview: UITableView! {
        didSet {
            tableViewReview.register(UINib(nibName: "ReviewTVCell", bundle: nil), forCellReuseIdentifier: "ReviewTVCell")
        }
    }
    
    var arrReview = [ReviewResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewReview.delegate = self
        self.tableViewReview.dataSource = self
        
        self.setDataForReview()
    }
    
    func setDataForReview() {
        
        let param = [
            "api_key": GlobalConstants.apiKey,
            "language": "en-US",
            "page": "1"
        ]
        
        SVProgressHUD.show()
        APIManager.getReviewList(params: param, movieId: SharedInstance.sharedInstance.movieId, success: { (review) in
            SVProgressHUD.dismiss()
            self.arrReview.removeAll()
            self.arrReview.append(contentsOf: review.results)
            self.tableViewReview.reloadData()
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrReview.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTVCell", for: indexPath) as! ReviewTVCell
        
        cell.refreshData(review: self.arrReview[indexPath.row])
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //CellAnimator.animate(cell, withDuration: 0.5, animation: .Tilt)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ReviewsVC: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Reviews")
    }
}
