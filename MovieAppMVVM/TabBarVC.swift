//
//  TabBarVC.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 22/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
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
        
        self.viewControllers = [
            createNavigationController(with: HomeVC(), title: "Home", image: #imageLiteral(resourceName: "home")),
            createNavigationController(with: SearchVC(), title: "Search", image: #imageLiteral(resourceName: "search")),
            createNavigationController(with: FavouriteVC(), title: "Favourite", image: #imageLiteral(resourceName: "favourite")),
            createNavigationController(with: MoreVC(), title: "More", image: #imageLiteral(resourceName: "more"))
        ]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hex: "9e9e9e")], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.themeCherry], for: .selected)
    }
    
    func createNavigationController(with viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navgationController = UINavigationController(rootViewController: viewController)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        viewController.navigationItem.title = title
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return navgationController
    }
}

extension TabBarVC: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
