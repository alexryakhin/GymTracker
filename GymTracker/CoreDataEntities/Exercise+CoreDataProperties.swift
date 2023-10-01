//
//  Exercise+CoreDataProperties.swift
//  GymTracker
//
//  Created by Aleksandr Riakhin on 10/1/23.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var index: Int16
    @NSManaged public var name: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var instruction: String?
    @NSManaged public var workout: Workout?
    @NSManaged public var sets: NSSet?

    var name_: String {
        return name ?? "Unknown Exercise"
    }

    var instruction_: String {
        return name ?? "Unknown Instruction"
    }

    var sets_: [ExerciseSet] {
        let sets = sets as? Set<ExerciseSet> ?? []
        return sets.sorted {
            $0.index < $1.index
        }
    }

}

// MARK: Generated accessors for sets
extension Exercise {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: ExerciseSet)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: ExerciseSet)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}

extension Exercise : Identifiable {

}
