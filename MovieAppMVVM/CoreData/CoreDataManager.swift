//
//  CoreDataManager.swift
//  MyCoreDataProject
//
//  Created by Shahanshah Manzoor on 10/04/19.
//  Copyright © 2019 Simpliv LLC. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    // will live forever as long as your application is still alive, it's properties will too...
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MovieCoreData")
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchFavouriteMovies() -> [Favourite] {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Favourite>(entityName: "Favourite")
        
        do {
            let favouriteMovies = try context.fetch(fetchRequest)
            return favouriteMovies
        } catch let fetchErr {
            print("Failed to fetch favourite movies: ", fetchErr)
            return []
        }
    }
    
    func addFavouriteMovies(voteCount: Int, id: Int, video: Bool, voteAverage: Double, title: String, popularity: Double, posterPath: String, originalLanguage: String, originalTitle: String, backdropPath: String, adult: Bool, overview: String, releaseDate: String) {
        
        let context = persistentContainer.viewContext
        let movie = NSEntityDescription.insertNewObject(forEntityName: "Favourite", into: context) as! Favourite
        
        movie.setValue(voteCount, forKey: "voteCount")
        movie.setValue(id, forKey: "id")
        movie.setValue(video, forKey: "video")
        movie.setValue(voteAverage, forKey: "voteAverage")
        movie.setValue(title, forKey: "title")
        movie.setValue(popularity, forKey: "popularity")
        movie.setValue(posterPath, forKey: "posterPath")
        movie.setValue(originalLanguage, forKey: "originalLanguage")
        movie.setValue(originalTitle, forKey: "originalTitle")
        movie.setValue(backdropPath, forKey: "backdropPath")
        movie.setValue(adult, forKey: "adult")
        movie.setValue(overview, forKey: "overview")
        movie.setValue(releaseDate, forKey: "releaseDate")
        
        do {
            try context.save()
        } catch let err {
            print("Failed to create favourite movie: ", err)
        }
    }
    
    func deleteMovie(id: Int64) {
        
        let request: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        
        request.predicate = NSPredicate(format: "id == %@", "\(id)")
        
        let context = persistentContainer.viewContext
        let movie = try? context.fetch(request)
        
        movie?.forEach { (movie) in
            context.delete(movie)
        }
        try? context.save()
    }
}
