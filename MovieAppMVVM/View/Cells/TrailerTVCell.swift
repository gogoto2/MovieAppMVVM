//
//  TrailerTVCell.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

protocol VideoCellDelegate: class {
    func openYoutubeVideo(_ sender: TrailerTVCell)
    func shareVideo(_ sender: TrailerTVCell)
}

class TrailerTVCell: UITableViewCell {
    
    @IBOutlet weak var viewCard: CardView!
    @IBOutlet weak var imgVideo: UIImageView!
    
    @IBOutlet weak var imgYoutube: UIImageView!
    @IBOutlet weak var lblVideoTitle: UILabel!
    
    @IBOutlet weak var btnOpenOnYoutube: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    var delegate: VideoCellDelegate?
    
    @IBAction func tapOpenOnYoutubeBtn(_ sender: UIButton) {
        self.delegate?.openYoutubeVideo(self)
    }
    
    @IBAction func tapShareBtn(_ sender: UIButton) {
        self.delegate?.shareVideo(self)
    }
    
    func refreshData(videos: TrailerResults) {
        
        let url = "https://img.youtube.com/vi/\(videos.key)/hqdefault.jpg"
        self.imgVideo.sd_setShowActivityIndicatorView(true)
        self.imgVideo.sd_setIndicatorStyle(.gray)
        self.imgVideo.sd_setImage(with: URL(string: url), placeholderImage:#imageLiteral(resourceName: "cinema"), options:.refreshCached)
        
        self.lblVideoTitle.text = videos.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.btnShare.layer.cornerRadius = self.btnShare.frame.height/2
        self.btnShare.layer.masksToBounds = true
        //self.imgVideo.roundCorners([.topLeft, .topRight], radius: 5.0)
    }
}
