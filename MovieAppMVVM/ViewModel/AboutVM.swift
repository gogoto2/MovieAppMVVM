//
//  AboutVM.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 03/09/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import Foundation

class AboutViewModel {
    
    var movieDetails: MovieDetails?
    var arrCast = [CastResults]()
    
    func getParameters(apiKey: String, language: String) -> [String: String] {
        let param = [
            "api_key": apiKey,
            "language": language
        ]
        return param
    }
    
    func getParameters(apiKey: String) -> [String: String] {
        let param = [
            "api_key": apiKey
        ]
        return param
    }
}
