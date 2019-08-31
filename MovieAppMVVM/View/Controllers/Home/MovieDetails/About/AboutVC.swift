//
//  AboutVC.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SVProgressHUD

class AboutVC: UIViewController {
    
    @IBOutlet weak var tableViewAbout: UITableView! {
        didSet {
            tableViewAbout.register(UINib(nibName: "ImageTVCell", bundle: nil), forCellReuseIdentifier: "ImageTVCell")
            tableViewAbout.register(UINib(nibName: "MovieNameTVCell", bundle: nil), forCellReuseIdentifier: "MovieNameTVCell")
            tableViewAbout.register(UINib(nibName: "TitleAndValueTVCell", bundle: nil), forCellReuseIdentifier: "TitleAndValueTVCell")
            tableViewAbout.register(UINib(nibName: "OverviewTVCell", bundle: nil), forCellReuseIdentifier: "OverviewTVCell")
            tableViewAbout.register(UINib(nibName: "CollectionViewInsideTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionViewInsideTableViewCell")
            tableViewAbout.register(UINib(nibName: "TitleAndButtonTVCell", bundle: nil), forCellReuseIdentifier: "TitleAndButtonTVCell")
        }
    }
    
    var movieDetails: MovieDetails?
    
    var arrCast = [CastResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewAbout.delegate = self
        self.tableViewAbout.dataSource = self
        
        self.tableViewAbout.isHidden = true
        
        self.setDataForMovieDetails()
    }
    
    func setDataForMovieDetails() {
        let param = [
            "api_key": GlobalConstants.apiKey,
            "language": "en-US"
        ]
        SVProgressHUD.show()
        APIManager.getMovieDetails(params: param, movieId: SharedInstance.sharedInstance.movieId, success: { (movieDetails) in
            SVProgressHUD.dismiss()
            self.movieDetails = movieDetails
            self.setDataForMovieCredits()
        }) { (errMsg) in
            print(errMsg)
        }
    }
    
    func setDataForMovieCredits() {
        let param = [
            "api_key": GlobalConstants.apiKey
        ]
        
        SVProgressHUD.show()
        APIManager.getMovieCredits(params: param, movieId: SharedInstance.sharedInstance.movieId, success: { (credit) in
            SVProgressHUD.dismiss()
            self.arrCast.removeAll()
            self.arrCast.append(contentsOf: credit.cast)
            self.tableViewAbout.reloadData()
            self.tableViewAbout.isHidden = false
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension AboutVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 2
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return 1
        } else if section == 5 {
            return 1
        } else if section == 6 {
            return 1
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.movieDetails != nil {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTVCell", for: indexPath) as! ImageTVCell
                cell.refreshData(movieDetails: self.movieDetails!)
                return cell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieNameTVCell", for: indexPath) as! MovieNameTVCell
                cell.refreshData(movieDetails: self.movieDetails!)
                return cell
            } else if indexPath.section == 2 {
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TitleAndValueTVCell", for: indexPath) as! TitleAndValueTVCell
                    cell.refreshDataForDate(movieDetails: self.movieDetails!)
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TitleAndValueTVCell", for: indexPath) as! TitleAndValueTVCell
                    cell.refreshDataForRating(movieDetails: self.movieDetails!)
                    return cell
                }
            } else if indexPath.section == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewInsideTableViewCell", for: indexPath) as! CollectionViewInsideTableViewCell
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                cell.collectionView.tag = 1
                cell.collectionView.reloadData()
                return cell
            } else if indexPath.section == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTVCell", for: indexPath) as! OverviewTVCell
                cell.refreshData(movieDetails: self.movieDetails!)
                return cell
            } else if indexPath.section == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleAndButtonTVCell", for: indexPath) as! TitleAndButtonTVCell
                cell.refreshData()
                cell.delegate = self
                return cell
            } else if indexPath.section == 6 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewInsideTableViewCell", for: indexPath) as! CollectionViewInsideTableViewCell
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                cell.collectionView.tag = 2
                cell.collectionView.reloadData()
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 220
        case 1:
            return UITableView.automaticDimension
        case 2:
            if indexPath.row == 0 {
                return 40
            } else if indexPath.row == 1 {
                return 40
            } else {
                return 0
            }
        case 3:
            return 60
        case 4:
            return UITableView.automaticDimension
        case 5:
            return 30
        case 6:
            return 230
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //CellAnimator.animate(cell, withDuration: 0.5, animation: .Tilt)
    }
}

extension AboutVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1 {
            return (self.movieDetails?.genres.count)!
        } else {
            return self.arrCast.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCVCell", for: indexPath) as? GenreCVCell else {
                print("------- Cell cannot be created")
                return UICollectionViewCell()
            }
            cell.refreshData(genre: (self.movieDetails?.genres[indexPath.item])!)
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCVCell", for: indexPath) as? CastCVCell else {
                print("------- Cell cannot be created")
                return UICollectionViewCell()
            }
            cell.refreshData(credits: self.arrCast[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCVCell", for: indexPath) as? GenreCVCell
            cell!.refreshData(genre: (self.movieDetails?.genres[indexPath.item])!)
            cell!.setNeedsLayout()
            cell!.layoutIfNeeded()
            let size: CGSize = cell!.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            return CGSize(width: size.width, height: 30)
            
        } else {
            return CGSize(width: 130.0, height: 200.0)
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        CellAnimatorForCV.animate(cell, withDuration: 0.5, animation: .Tilt)
    }
}

extension AboutVC: TitleAndButtonTVCellDelegate {
    
    func tapOnButton(_ sender: TitleAndButtonTVCell) {
        
    }
}

extension AboutVC: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "About")
    }
}
