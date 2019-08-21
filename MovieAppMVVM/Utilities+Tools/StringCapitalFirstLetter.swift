//
//  StringCapitalFirstLetter.swift
//  AGMoviesApp
//
//  Created by Macbook on 26/07/18.
//  Copyright © 2018 Ayush Gupta. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
