//
//  FavouriteVC.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 23/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let isRefresh = Notification.Name("isRefresh")
}

class FavouriteVC: UIViewController {
    
    @IBOutlet weak var collectionViewFavourite: UICollectionView! {
        didSet {
            collectionViewFavourite.register(UINib(nibName: "MovieCVCellTypeTwo", bundle: nil), forCellWithReuseIdentifier: "MovieCVCellTypeTwo")
        }
    }
    
    var favouriteVM = FavouriteViewModel()
    private var dataSource: CollectionViewDataSource<MovieCVCellTypeTwo, Favourite>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh(notification:)), name: .isRefresh, object: nil)
        
        self.navigationItem.title = "Favourite Movie"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.dataSource = CollectionViewDataSource(cellIdentifier: "MovieCVCellTypeTwo", items: self.favouriteVM.arrFavouriteMovie) { cell, vm in
            cell.refreshData(favouriteMovie: vm)
        }
        self.collectionViewFavourite.dataSource = self.dataSource
        self.collectionViewFavourite.delegate = self
        
        self.setData()
    }
    
    @objc func refresh(notification: Notification) {
        self.setData()
    }
    
    func setData() {
        self.favouriteVM.arrFavouriteMovie.removeAll()
        self.favouriteVM.arrFavouriteMovie = CoreDataManager.shared.fetchFavouriteMovies()
        self.dataSource.updateItems(self.favouriteVM.arrFavouriteMovie)
        self.collectionViewFavourite.reloadData()
    }
}

extension FavouriteVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailVC(nibName: "MovieDetailVC", bundle: nil)
        SharedInstance.sharedInstance.movieId = String(self.favouriteVM.arrFavouriteMovie[indexPath.item].id)
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
