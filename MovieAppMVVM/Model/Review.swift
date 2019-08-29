//
//  Review.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import Foundation

struct Review: Codable {
    
    var id: Int
    var page: Int
    var results: [ReviewResults]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct ReviewResults: Codable {
    
    var author : String
    var content : String
    var id : String
    var url : String
    
    enum CodingKeys: String, CodingKey {
        case author
        case content
        case id
        case url
    }
}
