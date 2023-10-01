//
//  Workout+CoreDataProperties.swift
//  GymTracker
//
//  Created by Aleksandr Riakhin on 10/1/23.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var exercises: NSSet?

    var name_: String {
        return name ?? "New Workout"
    }

    var type_: String {
        return name ?? "Unknown type"
    }

    var exericises_: [Exercise] {
        let exercises = exercises as? Set<Exercise> ?? []
        return exercises.sorted {
            $0.index < $1.index
        }
    }

}

// MARK: Generated accessors for exercises
extension Workout {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}

extension Workout : Identifiable {

}
