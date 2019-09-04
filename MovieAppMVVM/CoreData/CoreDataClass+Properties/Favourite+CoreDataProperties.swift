//
//  Favourite+CoreDataProperties.swift
//  
//
//  Created by Ayush Gupta on 04/09/19.
//
//

import Foundation
import CoreData

extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var voteCount: Int16
    @NSManaged public var id: Int64
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double
    @NSManaged public var title: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var backdropPath: String?
    @NSManaged public var adult: Bool
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: String?

}
