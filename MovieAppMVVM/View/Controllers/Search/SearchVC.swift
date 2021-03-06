//
//  SearchVC.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 23/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SVProgressHUD

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionViewSearch: UICollectionView! {
        didSet {
            collectionViewSearch.register(UINib(nibName: "MovieCVCellTypeTwo", bundle: nil), forCellWithReuseIdentifier: "MovieCVCellTypeTwo")
        }
    }
    
    var movieListVM = MovieViewModel()
    private var dataSource: CollectionViewDataSource<MovieCVCellTypeTwo, MovieResults>!
    
    var isInProgress = false
    var total = Int()
    var page = 1
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(SearchVC.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.init(hexString: "FF4545")
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search Movie"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.dataSource = CollectionViewDataSource(cellIdentifier: "MovieCVCellTypeTwo", items: self.movieListVM.arrMovieList) { cell, vm in
            cell.refreshData(movie: vm)
        }
        self.collectionViewSearch.dataSource = self.dataSource
        self.collectionViewSearch.delegate = self
        
        self.collectionViewSearch.addSubview(self.refreshControl)
        
        self.searchBar.delegate = self
        self.keyBoardTool()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.page = 1
        self.movieListVM.arrMovieList.removeAll()
        self.collectionViewSearch.reloadData()
        self.setDataForSearchMovies(query: self.searchBar.text ?? "", isRefresh: true)
        refreshControl.endRefreshing()
    }
    
    func keyBoardTool() {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .blackTranslucent
        toolBar.isTranslucent = true
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        self.searchBar.inputAccessoryView = toolBar
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
        
        if self.searchBar.text != "" {
            self.searchBar.endEditing(true)
            self.page = 1
            self.movieListVM.arrMovieList.removeAll()
            self.collectionViewSearch.reloadData()
            self.setDataForSearchMovies(query: self.searchBar.text ?? "", isRefresh: false)
        }
    }
    
    func setDataForSearchMovies(query: String, isRefresh: Bool) {
        
        if self.isInProgress {
            return
        }
        self.isInProgress = true
        if !isRefresh {
            SVProgressHUD.show()
        }
        
        let url = GlobalConstants.baseUrlForSearch
        let param = self.movieListVM.getParameters(apiKey: GlobalConstants.apiKey, language: "en-US", pageCount: String(self.page), query: self.searchBar.text ?? "", isAdult: "true")
        APIManager.getSearchedMovieList(url: url, params: param, success: { (movie) in
            SVProgressHUD.dismiss()
            self.isInProgress = false
            self.total = movie.totalResults
            self.movieListVM.arrMovieList.append(contentsOf: movie.results)
            self.dataSource.updateItems(self.movieListVM.arrMovieList)
            self.collectionViewSearch.reloadData()
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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

//MARK: search controller delegate
extension SearchVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.page = 1
        self.searchBar.text = ""
        self.movieListVM.arrMovieList.removeAll()
        self.collectionViewSearch.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.searchBar.endEditing(true)
            self.page = 1
            self.movieListVM.arrMovieList.removeAll()
            self.collectionViewSearch.reloadData()
            self.setDataForSearchMovies(query: text, isRefresh: false)
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension SearchVC {
    
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
            self.setDataForSearchMovies(query: self.searchBar.text ?? "", isRefresh: false)
        }
    }
}
