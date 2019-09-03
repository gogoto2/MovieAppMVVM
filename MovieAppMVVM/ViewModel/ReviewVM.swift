//
//  ReviewVM.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 03/09/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import Foundation

class ReviewViewModel {
    
    var arrReview = [ReviewResults]()
    
    func getParameters(apiKey: String, language: String, pageCount: String) -> [String: String] {
        let param = [
            "api_key": apiKey,
            "language": language,
            "page": pageCount
        ]
        return param
    }
}
