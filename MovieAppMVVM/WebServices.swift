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
    class func getMovieList(params: [String: String], movieType: String, success: @escaping (_ movie: Movie)->(), failure: @escaping (_ errorMessage: String)->()) {
        
        let url = "https://api.themoviedb.org/3/movie/" + movieType
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            
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
