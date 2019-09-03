//
//  TrailerVM.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 03/09/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import Foundation

class TrailerViewModel {
    
    var arrVideos = [TrailerResults]()
    
    func getParameters(apiKey: String) -> [String: String] {
        let param = [
            "api_key": apiKey
        ]
        return param
    }
}
