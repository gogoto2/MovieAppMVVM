//
//  CastVC.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SVProgressHUD

class CastVC: UIViewController {

    @IBOutlet weak var collectionViewCast: UICollectionView! {
        didSet {
            collectionViewCast.register(UINib(nibName: "CastCVCell", bundle: nil), forCellWithReuseIdentifier: "CastCVCell")
        }
    }
    
    var arrCast = [CastResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionViewCast.delegate = self
        self.collectionViewCast.dataSource = self
        
        self.setDataForMovieCredits()
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
            self.collectionViewCast.reloadData()
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension CastVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCVCell", for: indexPath) as? CastCVCell else {
            print("------- Cell cannot be created")
            return UICollectionViewCell()
        }
        
        cell.refreshData(credits: self.arrCast[indexPath.item])
        
        return cell
    }
}

extension CastVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2, height: 200.0)
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

extension CastVC: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Cast")
    }
}
