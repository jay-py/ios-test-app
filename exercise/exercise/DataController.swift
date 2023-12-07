//
//  CoreDataMovieManager.swift
//
//
//  Created by Jean paul on 2023-12-06.
//
import CoreData
import Domain

final class DataController {

    public static let shared = DataController()
    public let container: NSPersistentContainer
    public var movies: [Movie] {
        get { return self.getMovies() ?? [] }
        set { self.cacheMovies(newValue) }
    }

    private init() {
        container = NSPersistentContainer(name: "CachedDataModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    fileprivate func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    fileprivate func cacheMovies(_ movies: [Movie]) {
        movies.forEach(cacheMovie)
    }

    fileprivate func cacheMovie(_ movie: Movie) {
        let context = self.container.viewContext
        let cacheMovie = CachedMovie(context: context)
        cacheMovie.id = UUID()
        cacheMovie.expirationDate = Date().addingTimeInterval(12 * 60 * 60)  // 12 hours from now
        cacheMovie.title = movie.title
        cacheMovie.released = movie.released
        cacheMovie.poster = movie.poster
        cacheMovie.plot = movie.plot
        save(context: context)
        print("success saving!")
    }

    fileprivate func getMovies() -> [Movie]? {
        let context = self.container.viewContext
        let request: NSFetchRequest<CachedMovie> = CachedMovie.fetchRequest()
        guard let cachedMovies = try? context.fetch(request)
        else { return nil }
        let expiredCache = cachedMovies.filter { $0.expirationDate <= Date() }
        let validMovies = cachedMovies.filter { $0.expirationDate > Date() }
        let movies = validMovies.compactMap {
            Movie(
                title: $0.title,
                released: $0.released,
                poster: $0.poster,
                plot: $0.plot,
                genre: $0.genre)
        }
        print("sucess getting")
        return movies
    }
}
