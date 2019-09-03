//
//  MovieListVC.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 28/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit
import SVProgressHUD

class MovieListVC: UIViewController {
    
    @IBOutlet weak var collectionViewMovie: UICollectionView! {
        didSet {
            collectionViewMovie.register(UINib(nibName: "MovieCVCellTypeTwo", bundle: nil), forCellWithReuseIdentifier: "MovieCVCellTypeTwo")
        }
    }
    
    var movieListVM = MovieViewModel()
    private var dataSource: CollectionViewDataSource<MovieCVCellTypeTwo, MovieResults>!
    
    var movieType = ""
    var isInProgress = false
    var total = Int()
    var page = 1
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(MovieListVC.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.init(hexString: "FF4545")
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.movieListVM.movieType(value: self.movieType)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.dataSource = CollectionViewDataSource(cellIdentifier: "MovieCVCellTypeTwo", items: self.movieListVM.arrMovieList) { cell, vm in
            cell.refreshData(movie: vm)
        }
        self.collectionViewMovie.dataSource = self.dataSource
        self.collectionViewMovie.delegate = self
        
        self.collectionViewMovie.addSubview(self.refreshControl)
        
        self.setDataForMovies(movieType: self.movieType, isRefresh: false)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.page = 1
        self.movieListVM.arrMovieList.removeAll()
        self.collectionViewMovie.reloadData()
        self.setDataForMovies(movieType: self.movieType, isRefresh: true)
        refreshControl.endRefreshing()
    }
    
    func setDataForMovies(movieType: String, isRefresh: Bool) {
        
        if self.isInProgress {
            return
        }
        self.isInProgress = true
        let param = self.movieListVM.getParameters(apiKey: GlobalConstants.apiKey, language: "en-US", pageCount: String(self.page))
        let url = GlobalConstants.baseUrl + movieType
        if !isRefresh {
            SVProgressHUD.show()
        }
        APIManager.getMovieList(params: param, url: url, success: { (movie) in
            SVProgressHUD.dismiss()
            self.isInProgress = false
            self.total = movie.totalResults
            self.movieListVM.arrMovieList.append(contentsOf: movie.results)
            self.dataSource.updateItems(self.movieListVM.arrMovieList)
            self.collectionViewMovie.reloadData()
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension MovieListVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailVC(nibName: "MovieDetailVC", bundle: nil)
        SharedInstance.sharedInstance.movieId = String(self.movieListVM.arrMovieList[indexPath.item].id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 130.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //CellAnimatorForCV.animate(cell, withDuration: 0.5, animation: .Tilt)
    }
}

extension MovieListVC {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.loadMoreData(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.loadMoreData(scrollView)
        }
    }
    
    func loadMoreData(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height) && !isInProgress && self.total > self.movieListVM.arrMovieList.count {
            self.page += 1
            self.setDataForMovies(movieType: self.movieType, isRefresh: false)
        }
    }
}
