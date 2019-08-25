//
//  Popular.swift
//  AGMoviesApp
//
//  Created by Macbook on 16/07/18.
//  Copyright © 2018 Ayush Gupta. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    let results: [Result]
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
