//
//  SharedInstance.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import Foundation

class SharedInstance {
    
    var movieId : String = ""
    
    class var sharedInstance: SharedInstance {
        struct Static {
            static let instance: SharedInstance = SharedInstance()
        }
        return Static.instance
    }
}
