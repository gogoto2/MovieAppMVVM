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
    
    var arrMovieList = [MovieResults]()
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search Movie"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.collectionViewSearch.delegate = self
        self.collectionViewSearch.dataSource = self
        
        self.searchBar.delegate = self
        self.keyBoardTool()
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
            self.arrMovieList.removeAll()
            self.collectionViewSearch.reloadData()
            self.setDataForUpcomingMovies(query: self.searchBar.text ?? "")
        }
    }
    
    func setDataForUpcomingMovies(query: String) {
        
        let param = [
            "api_key": GlobalConstants.apiKey,
            "language": "en-US",
            "page": String(self.page),
            "query": query,
            "include_adult": "true"
        ]
        
        SVProgressHUD.show()
        APIManager.getSearchedMovieList(params: param, success: { (movie) in
            SVProgressHUD.dismiss()
            self.arrMovieList.removeAll()
            self.arrMovieList.append(contentsOf: movie.results)
            self.collectionViewSearch.reloadData()
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension SearchVC: UICollectionViewDataSource {
    
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

extension SearchVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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

//MARK: search controller delegate
extension SearchVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.page = 1
        self.searchBar.text = ""
        self.arrMovieList.removeAll()
        self.collectionViewSearch.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.searchBar.endEditing(true)
            self.page = 1
            self.arrMovieList.removeAll()
            self.collectionViewSearch.reloadData()
            self.setDataForUpcomingMovies(query: text)
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
