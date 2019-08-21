//
//  TabBar.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 22/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupTabBar()
    }
    
    func setupTabBar() {
        
        UITabBar.appearance().tintColor = UIColor.themeCherry
        UITabBar.appearance().barStyle = .black
        
        // Create Tab one
        let movieVC = MovieVC()
        let movie = UITabBarItem(title: "Movie", image: #imageLiteral(resourceName: "MOVIE"), selectedImage: #imageLiteral(resourceName: "MOVIE"))
        movieVC.tabBarItem = movie
        
        // Create Tab two
        let tvVC = TVVC()
        let tv = UITabBarItem(title: "TV", image: #imageLiteral(resourceName: "TV"), selectedImage: #imageLiteral(resourceName: "TV"))
        tvVC.tabBarItem = tv
        
        self.viewControllers = [movieVC, tvVC]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hex: "9e9e9e")], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.themeCherry], for: .selected)
    }
}

extension TabBar: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
