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
    
    var reviewVM = ReviewViewModel()
    private var dataSource: TableViewDataSource<ReviewTVCell, ReviewResults>!
    
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
        
        self.initialSetUp()
    }
    
    func initialSetUp() {
        
        self.dataSource = TableViewDataSource(cellIdentifier: "ReviewTVCell", items: self.reviewVM.arrReview) { cell, vm in
            cell.refreshData(review: vm)
        }
        self.tableViewReview.dataSource = self.dataSource
        self.tableViewReview.delegate = self
        self.tableViewReview.addSubview(self.refreshControl)
        
        self.setDataForReview(isRefresh: false)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.page = 1
        self.reviewVM.arrReview.removeAll()
        self.tableViewReview.reloadData()
        self.setDataForReview(isRefresh: true)
        refreshControl.endRefreshing()
    }
    
    func setDataForReview(isRefresh: Bool) {
        
        if self.isInProgress {
            return
        }
        self.isInProgress = true
        if !isRefresh {
            SVProgressHUD.show()
        }
        
        let param = self.reviewVM.getParameters(apiKey: GlobalConstants.apiKey, language: "en-US", pageCount: String(self.page))
        let url = GlobalConstants.baseUrl + SharedInstance.sharedInstance.movieId + "/reviews"
        APIManager.getReviewList(url: url, params: param, success: { (review) in
            SVProgressHUD.dismiss()
            self.isInProgress = false
            self.total = review.totalResults
            self.reviewVM.arrReview.append(contentsOf: review.results)
            self.dataSource.updateItems(self.reviewVM.arrReview)
            self.tableViewReview.reloadData()
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension ReviewsVC: UITableViewDelegate {
    
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
        if (scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height) && !isInProgress && self.total > self.reviewVM.arrReview.count {
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
