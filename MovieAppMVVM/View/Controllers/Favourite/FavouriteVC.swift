//
//  FavouriteVC.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 23/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class FavouriteVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Favourite Movie"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}
