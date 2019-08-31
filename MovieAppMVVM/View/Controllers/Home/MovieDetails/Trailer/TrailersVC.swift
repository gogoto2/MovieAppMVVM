//
//  TrailersVC.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SVProgressHUD

class TrailersVC: UIViewController {
    
    @IBOutlet weak var tableViewTrailer: UITableView! {
        didSet {
            tableViewTrailer.register(UINib(nibName: "TrailerTVCell", bundle: nil), forCellReuseIdentifier: "TrailerTVCell")
        }
    }
    
    var arrVideos = [TrailerResults]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(TrailersVC.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.init(hexString: "FF4545")
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewTrailer.delegate = self
        self.tableViewTrailer.dataSource = self
        
        self.tableViewTrailer.addSubview(self.refreshControl)
        
        self.setDataForMovieCredits(isRefresh: false)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.arrVideos.removeAll()
        self.tableViewTrailer.reloadData()
        self.setDataForMovieCredits(isRefresh: true)
        refreshControl.endRefreshing()
    }
    
    func setDataForMovieCredits(isRefresh: Bool) {
        let param = [
            "api_key": GlobalConstants.apiKey
        ]
        if !isRefresh {
            SVProgressHUD.show()
        }
        APIManager.getMovieVideos(params: param, movieId: SharedInstance.sharedInstance.movieId, success: { (video) in
            SVProgressHUD.dismiss()
            self.arrVideos.append(contentsOf: video.results)
            self.tableViewTrailer.reloadData()
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension TrailersVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if self.arrVideos.count > 0 {
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
        return self.arrVideos.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerTVCell", for: indexPath) as! TrailerTVCell
        cell.refreshData(videos: self.arrVideos[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //CellAnimator.animate(cell, withDuration: 0.5, animation: .Tilt)
    }
}

extension TrailersVC: VideoCellDelegate {
    
    func openYoutubeVideo(_ sender: TrailerTVCell) {
        
        guard let tappedIndexPath = self.tableViewTrailer.indexPath(for: sender) else { return }
        let youtubeId = self.arrVideos[tappedIndexPath.item].key
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        
        if UIApplication.shared.canOpenURL(youtubeUrl as URL) {
            UIApplication.shared.open(youtubeUrl as URL)
        } else {
            youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            UIApplication.shared.open(youtubeUrl as URL)
        }
    }
    
    func shareVideo(_ sender: TrailerTVCell) {
        
        guard let tappedIndexPath = self.tableViewTrailer.indexPath(for: sender) else { return }
        let key = self.arrVideos[tappedIndexPath.item].key
        let videoUrl = NSURL(string:"https://www.youtube.com/watch?v=\(key)")!
        
        let activityVC = UIActivityViewController(activityItems: [videoUrl], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
}

extension TrailersVC: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Trailers")
    }
}
