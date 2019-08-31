//
//  TitleAndButtonTVCell.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 31/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

protocol TitleAndButtonTVCellDelegate {
    func tapOnButton(_ sender: TitleAndButtonTVCell)
}

class TitleAndButtonTVCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    
    var delegate: TitleAndButtonTVCellDelegate?
    
    @IBAction func tapOnButton(_ sender: UIButton) {
        self.delegate?.tapOnButton(self)
    }
    
    func refreshData() {
        self.lblTitle.text = "Cast Members"
        self.btnViewAll.isHidden = true
    }
}
