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
    
    var arrMovieList = [MovieResults]()
    
    var movieType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.movieType(value: self.movieType)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.collectionViewMovie.delegate = self
        self.collectionViewMovie.dataSource = self
        
        self.setDataForUpcomingMovies(movieType: self.movieType)
    }
    
    func movieType(value: String) -> String {
        var navTitle = ""
        switch value {
        case "upcoming":
            navTitle = "Upcomping Movies"
        case "top_rated":
            navTitle = "Top Rated Movies"
        case "popular":
            navTitle = "Popular Movies"
        default:
            break
        }
        return navTitle
    }
    
    func setDataForUpcomingMovies(movieType: String) {
        
        let param = [
            "api_key": GlobalConstants.apiKey,
            "language": "en-US",
            "page": "1"
        ]
        
        SVProgressHUD.show()
        APIManager.getMovieList(params: param, movieType: movieType, success: { (movie) in
            SVProgressHUD.dismiss()
            self.arrMovieList.removeAll()
            self.arrMovieList.append(contentsOf: movie.results)
            self.collectionViewMovie.reloadData()
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension MovieListVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCellTypeTwo", for: indexPath) as? MovieCVCellTypeTwo else {
            print("------- Cell cannot be created")
            return UICollectionViewCell()
        }
        
        cell.refreshData(movie: self.arrMovieList[indexPath.item])
        
        return cell
    }
}

extension MovieListVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailVC(nibName: "MovieDetailVC", bundle: nil)
        SharedInstance.sharedInstance.movieId = String(self.arrMovieList[indexPath.item].id)
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
