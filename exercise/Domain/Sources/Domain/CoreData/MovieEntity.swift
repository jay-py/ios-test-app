//
//  CachedMovie+CoreDataProperties.swift
//  exercise
//
//  Created by Jean paul on 2023-12-06.
//
//

import CoreData
import Foundation

class CachedMovie: NSManagedObject {}
extension CachedMovie {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CachedMovie> {
        let request = NSFetchRequest<CachedMovie>(entityName: "CachedMovie")
        let sortDescriptor = NSSortDescriptor(key: "released", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
    @NSManaged var id: UUID
    @NSManaged var expirationDate: Date
    @NSManaged var title: String
    @NSManaged var poster: String
    @NSManaged var genre: String
    @NSManaged var released: String
    @NSManaged var plot: String
    @NSManaged var imageData: Data
}
