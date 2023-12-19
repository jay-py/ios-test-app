//
//  CoreDataMovieManager.swift
//
//
//  Created by Jean paul on 2023-12-06.
//
import CoreData
import SwiftUI

final class DataController: NSPersistentContainer {

    internal static let shared = DataController()
    fileprivate let expirationTime: TimeInterval = 12 * 60 * 60  // 12 hours
    fileprivate let dataModel: String = "CachedDataModel"

    fileprivate init() {
        guard
            let objectModelURL = Bundle.module.url(
                forResource: self.dataModel, withExtension: "momd"),
            let objectModel = NSManagedObjectModel(contentsOf: objectModelURL)
        else {
            fatalError("Failed to retrieve the object model")
        }
        super.init(name: self.dataModel, managedObjectModel: objectModel)

        self.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        self.viewContext.automaticallyMergesChangesFromParent = true
    }

    fileprivate func save(context: NSManagedObjectContext) async {
        do {
            context.performAndWait {
                try? context.save()
            }
        }
    }

    internal func cacheMovies(_ movies: [Movie]) async {
        for movie in movies {
            await self.cacheMovie(movie)
        }
        print(">> Saved items: ", movies.count)
    }

    fileprivate func cacheMovie(_ movie: Movie) async {
        let context = self.viewContext
        let cacheMovie = CachedMovie(context: context)
        cacheMovie.id = UUID()
        cacheMovie.expirationDate = Date().addingTimeInterval(expirationTime)
        cacheMovie.title = movie.title
        cacheMovie.released = movie.released
        cacheMovie.poster = movie.poster
        cacheMovie.plot = movie.plot
        cacheMovie.genre = movie.genre
        if let url = movie.imageURL,
            let imageData = try? Data(contentsOf: url)
        {
            cacheMovie.imageData = imageData
        }
        await save(context: context)
    }

    internal func getMovies() async -> [Movie]? {
        let context = self.viewContext
        let request: NSFetchRequest<CachedMovie> = CachedMovie.fetchRequest()

        guard
            let cachedMovies = await context.perform({
                try? context.fetch(request)
            })
        else { return nil }
        // remove expired
        let validMovies = cachedMovies.filter { $0.expirationDate > Date() }
        let expiredCache = cachedMovies.filter { $0.expirationDate < Date() }
        if !expiredCache.isEmpty {
            expiredCache.forEach { item in
                context.performAndWait {
                    context.delete(item)
                }
            }
            print(">> Removed expired items: ", expiredCache.count)
            await save(context: context)
        }
        if validMovies.isEmpty { return nil }
        let movies = validMovies.compactMap {
            var movie = Movie(
                title: $0.title,
                released: $0.released,
                poster: $0.poster,
                plot: $0.plot,
                genre: $0.genre)
            movie.imageData = $0.imageData
            return movie
        }
        print(">> Retrieved items: ", movies.count)
        return movies
    }
}
