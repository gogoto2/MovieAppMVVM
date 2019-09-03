//
//  HomeVC.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 23/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var collectionViewUpcomingMovie: UICollectionView! {
        didSet {
            collectionViewUpcomingMovie.register(UINib(nibName: "MovieCVCellTypeOne", bundle: nil), forCellWithReuseIdentifier: "MovieCVCellTypeOne")
        }
    }
    
    @IBOutlet weak var collectionViewTopRatedMovie: UICollectionView! {
        didSet {
            collectionViewTopRatedMovie.register(UINib(nibName: "MovieCVCellTypeOne", bundle: nil), forCellWithReuseIdentifier: "MovieCVCellTypeOne")
        }
    }
    
    @IBOutlet weak var collectionViewPopularMovie: UICollectionView! {
        didSet {
            collectionViewPopularMovie.register(UINib(nibName: "MovieCVCellTypeOne", bundle: nil), forCellWithReuseIdentifier: "MovieCVCellTypeOne")
        }
    }
    
    var movieListVM = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetUp()
    }
    
    func initialSetUp() {
        
        self.navigationItem.title = "Home"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.viewMain.isHidden = true
        
        self.collectionViewUpcomingMovie.delegate = self
        self.collectionViewUpcomingMovie.dataSource = self
        
        self.collectionViewTopRatedMovie.delegate = self
        self.collectionViewTopRatedMovie.dataSource = self
        
        self.collectionViewPopularMovie.delegate = self
        self.collectionViewPopularMovie.dataSource = self
        
        self.setDataForUpcomingMovies(movieType: "upcoming")
    }
    
    func setDataForUpcomingMovies(movieType: String) {
        
        let param = self.movieListVM.getParameters(apiKey: GlobalConstants.apiKey, language: "en-US", pageCount: "1")
        let url = GlobalConstants.baseUrl + movieType
        SVProgressHUD.show()
        APIManager.getMovieList(params: param, url: url, success: { (movie) in
            self.movieListVM.arrUpcomingMovieList.removeAll()
            self.movieListVM.arrUpcomingMovieList.append(contentsOf: movie.results)
            self.collectionViewUpcomingMovie.reloadData()
            
            self.setDataForTopRatedMovies(movieType: "top_rated")
            
        }) { (errMsg) in
            print(errMsg)
        }
    }
    
    func setDataForTopRatedMovies(movieType: String) {
        
        let param = self.movieListVM.getParameters(apiKey: GlobalConstants.apiKey, language: "en-US", pageCount: "1")
        let url = GlobalConstants.baseUrl + movieType
        APIManager.getMovieList(params: param, url: url, success: { (movie) in
            self.movieListVM.arrTopRatedMovieList.removeAll()
            self.movieListVM.arrTopRatedMovieList.append(contentsOf: movie.results)
            self.collectionViewTopRatedMovie.reloadData()
            
            self.setDataForPopularMovies(movieType: "popular")
            
        }) { (errMsg) in
            print(errMsg)
        }
    }
    
    func setDataForPopularMovies(movieType: String) {
        
        let param = self.movieListVM.getParameters(apiKey: GlobalConstants.apiKey, language: "en-US", pageCount: "1")
        let url = GlobalConstants.baseUrl + movieType
        APIManager.getMovieList(params: param, url: url, success: { (movie) in
            SVProgressHUD.dismiss()
            self.viewMain.isHidden = false
            self.movieListVM.arrPopularMovieList.removeAll()
            self.movieListVM.arrPopularMovieList.append(contentsOf: movie.results)
            self.collectionViewPopularMovie.reloadData()
        }) { (errMsg) in
            print(errMsg)
        }
    }
    
    @IBAction func tapOnMoreUpcomingBtn(_ sender: UIButton) {
        let vc = MovieListVC(nibName: "MovieListVC", bundle: nil)
        vc.movieType = "upcoming"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapOnMoreTopRatedBtn(_ sender: UIButton) {
        let vc = MovieListVC(nibName: "MovieListVC", bundle: nil)
        vc.movieType = "top_rated"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapOnMorePopularBtn(_ sender: UIButton) {
        let vc = MovieListVC(nibName: "MovieListVC", bundle: nil)
        vc.movieType = "popular"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewUpcomingMovie {
            return self.movieListVM.arrUpcomingMovieList.count
        } else if collectionView == self.collectionViewTopRatedMovie {
            return self.movieListVM.arrTopRatedMovieList.count
        } else if collectionView == self.collectionViewPopularMovie {
            return self.movieListVM.arrPopularMovieList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCellTypeOne", for: indexPath) as? MovieCVCellTypeOne else {
            print("------- Cell cannot be created")
            return UICollectionViewCell()
        }
        
        if collectionView == self.collectionViewUpcomingMovie {
            cell.refreshData(movie: self.movieListVM.arrUpcomingMovieList[indexPath.item])
        } else if collectionView == self.collectionViewTopRatedMovie {
            cell.refreshData(movie: self.movieListVM.arrTopRatedMovieList[indexPath.item])
        } else if collectionView == self.collectionViewPopularMovie {
            cell.refreshData(movie: self.movieListVM.arrPopularMovieList[indexPath.item])
        }
        
        return cell
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailVC(nibName: "MovieDetailVC", bundle: nil)
        if collectionView == self.collectionViewUpcomingMovie {
            SharedInstance.sharedInstance.movieId = String(self.movieListVM.arrUpcomingMovieList[indexPath.item].id)
        } else if collectionView == self.collectionViewTopRatedMovie {
            SharedInstance.sharedInstance.movieId = String(self.movieListVM.arrTopRatedMovieList[indexPath.item].id)
        } else if collectionView == self.collectionViewPopularMovie {
            SharedInstance.sharedInstance.movieId = String(self.movieListVM.arrPopularMovieList[indexPath.item].id)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180.0, height: 260.0)
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
        CellAnimatorForCV.animate(cell, withDuration: 0.5, animation: .Tilt)
    }
}
