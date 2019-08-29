//
//  Cast.swift
//  MovieAppMVVM
//
//  Created by Shahanshah Manzoor on 29/08/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import Foundation

struct Credits: Codable {
    
    let cast: [CastResults]
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case cast
        case id
    }
}

struct CastResults: Codable {
    
    var castId : Int
    var character : String
    var creditId : String
    var gender : Int
    var id : Int
    var name : String
    var order : Int
    var profilePath : String?
    
    enum CodingKeys: String, CodingKey {
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case gender
        case id
        case name
        case order
        case profilePath = "profile_path"
    }
}
