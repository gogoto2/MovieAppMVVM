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
    
    var isInProgress = false
    var total = Int()
    var page = 1
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ReviewsVC.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.init(hexString: "FF4545")
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewReview.delegate = self
        self.tableViewReview.dataSource = self
        
        self.tableViewReview.addSubview(self.refreshControl)
        
        self.setDataForReview(isRefresh: false)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.page = 1
        self.arrReview.removeAll()
        self.tableViewReview.reloadData()
        self.setDataForReview(isRefresh: true)
        refreshControl.endRefreshing()
    }
    
    func setDataForReview(isRefresh: Bool) {
        
        if self.isInProgress {
            return
        }
        self.isInProgress = true
        
        let param = [
            "api_key": GlobalConstants.apiKey,
            "language": "en-US",
            "page": String(self.page)
        ]
        
        if !isRefresh {
            SVProgressHUD.show()
        }
        APIManager.getReviewList(params: param, movieId: SharedInstance.sharedInstance.movieId, success: { (review) in
            SVProgressHUD.dismiss()
            self.isInProgress = false
            self.total = review.totalResults
            self.arrReview.append(contentsOf: review.results)
            self.tableViewReview.reloadData()
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if self.arrReview.count > 0 {
            numOfSections            = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No Records"
            noDataLabel.textColor     = UIColor.lightGray
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
        }
        return numOfSections
    }
    
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

extension ReviewsVC {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.loadMoreData(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.loadMoreData(scrollView)
        }
    }
    
    func loadMoreData(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height) && !isInProgress && self.total > self.arrReview.count {
            self.page += 1
            self.setDataForReview(isRefresh: false)
        }
    }
}

extension ReviewsVC: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Reviews")
    }
}
