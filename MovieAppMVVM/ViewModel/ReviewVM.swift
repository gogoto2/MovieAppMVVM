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
    
    func numberOfRows(_ section: Int) -> Int {
        return self.arrReview.count
    }
    
    func modelAt(_ index: Int) -> ReviewResults {
        return self.arrReview[index]
    }
    
    func getParameters(apiKey: String, language: String, pageCount: String) -> [String: String] {
        let param = [
            "api_key": apiKey,
            "language": language,
            "page": pageCount
        ]
        return param
    }
}
