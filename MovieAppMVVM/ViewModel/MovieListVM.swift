//
//  MovieListVM.swift
//  MovieAppMVVM
//
//  Created by Ayush Gupta on 02/09/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    var arrMovieList = [MovieResults]()
    var arrUpcomingMovieList = [MovieResults]()
    var arrTopRatedMovieList = [MovieResults]()
    var arrPopularMovieList = [MovieResults]()
    
    func getParameters(apiKey: String, language: String, pageCount: String) -> [String: String] {
        let param = [
            "api_key": apiKey,
            "language": language,
            "page": pageCount
        ]
        return param
    }
    
    func getParameters(apiKey: String, language: String, pageCount: String, query: String, isAdult: String) -> [String: String] {
        let param = [
            "api_key": apiKey,
            "language": language,
            "page": pageCount,
            "query": query,
            "include_adult": isAdult
        ]
        return param
    }
    
    func movieType(value: String) -> String {
        var navTitle = ""
        switch value {
        case "upcoming":
            navTitle = "Upcomping Movies"
        case "top_rated":
            navTitle = "Top Rated Movies"
        case "popular":
            navTitle = "Popular Movies"
        default:
            break
        }
        return navTitle
    }
}
