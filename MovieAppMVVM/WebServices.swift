//
//  WebServices.swift
//  NewsAppMVVM
//
//  Created by Netzealous on 14/01/19.
//  Copyright © 2019 Ayushmaan. All rights reserved.
//

import Foundation
import Alamofire

class APIManager: NSObject {
    
    // Movie... (Popular, Top_Rated, Upcoming)
    class func getMovieList(params: [String: String], url: String, success: @escaping (_ movie: Movie)->(), failure: @escaping (_ errorMessage: String)->()) {
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            
            print(response)
            
            guard response.error == nil else {
                print("error calliing on \(url)")
                return
            }
            
            guard let data = response.data else {
                print("there was an error with the data")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(Movie.self, from: data)
                success(model)
            } catch let jsonErr {
                print("failed to decode, \(jsonErr)")
            }
        }
    }
    
    // Movie Details...
    class func getMovieDetails(params: [String: String], movieId: String, success: @escaping (_ movieDetails: MovieDetails)->(), failure: @escaping (_ errorMessage: String)->()) {
        
        let url = GlobalConstants.baseUrl + movieId
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            
            print(response)
            
            guard response.error == nil else {
                print("error calliing on \(url)")
                return
            }
            
            guard let data = response.data else {
                print("there was an error with the data")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(MovieDetails.self, from: data)
                success(model)
            } catch let jsonErr {
                print("failed to decode, \(jsonErr)")
            }
        }
    }
    
    // Review...
    class func getReviewList(params: [String: String], movieId: String, success: @escaping (_ reviewList: Review)->(), failure: @escaping (_ errorMessage: String)->()) {
        
        let url = GlobalConstants.baseUrl + movieId + "/reviews"
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            
            print(response)
            
            guard response.error == nil else {
                print("error calliing on \(url)")
                return
            }
            
            guard let data = response.data else {
                print("there was an error with the data")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(Review.self, from: data)
                success(model)
            } catch let jsonErr {
                print("failed to decode, \(jsonErr)")
            }
        }
    }
    
    // Cast...
    class func getMovieCredits(params: [String: String], movieId: String, success: @escaping (_ credits: Credits)->(), failure: @escaping (_ errorMessage: String)->()) {
        
        let url = GlobalConstants.baseUrl + movieId + "/credits"
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            
            print(response)
            
            guard response.error == nil else {
                print("error calliing on \(url)")
                return
            }
            
            guard let data = response.data else {
                print("there was an error with the data")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(Credits.self, from: data)
                success(model)
            } catch let jsonErr {
                print("failed to decode, \(jsonErr)")
            }
        }
    }
    
    // Trailers...
    class func getMovieVideos(params: [String: String], movieId: String, success: @escaping (_ videos: Trailer)->(), failure: @escaping (_ errorMessage: String)->()) {
        
        let url = GlobalConstants.baseUrl + movieId + "/videos"
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            
            print(response)
            
            guard response.error == nil else {
                print("error calliing on \(url)")
                return
            }
            
            guard let data = response.data else {
                print("there was an error with the data")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(Trailer.self, from: data)
                success(model)
            } catch let jsonErr {
                print("failed to decode, \(jsonErr)")
            }
        }
    }
    
    // Search...
    class func getSearchedMovieList(url: String, params: [String: String], success: @escaping (_ movie: Movie)->(), failure: @escaping (_ errorMessage: String)->()) {
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            
            print(response)
            
            guard response.error == nil else {
                print("error calliing on \(url)")
                return
            }
            
            guard let data = response.data else {
                print("there was an error with the data")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(Movie.self, from: data)
                success(model)
            } catch let jsonErr {
                print("failed to decode, \(jsonErr)")
            }
        }
    }
}
