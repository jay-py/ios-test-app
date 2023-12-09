//
//  CachedMovie+CoreDataProperties.swift
//  exercise
//
//  Created by Jean paul on 2023-12-06.
//
//

import CoreData
import Foundation

public class CachedMovie: NSManagedObject {}
extension CachedMovie {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedMovie> {
        let request = NSFetchRequest<CachedMovie>(entityName: "CachedMovie")
        let sortDescriptor = NSSortDescriptor(key: "released", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
    @NSManaged public var id: UUID
    @NSManaged public var expirationDate: Date
    @NSManaged public var title: String
    @NSManaged public var poster: String
    @NSManaged public var genre: String
    @NSManaged public var released: String
    @NSManaged public var plot: String
    @NSManaged public var imageData: Data
}
