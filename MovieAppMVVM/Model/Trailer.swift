//
//  Trailer.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import Foundation

struct Trailer: Codable {
    
    let results: [TrailerResults]
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case id
    }
}

struct TrailerResults: Codable {
    
    var id : String
    var key : String
    var name : String
    var site : String
    var size : Int
    var type : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case key
        case name
        case site
        case size
        case type
    }
}
