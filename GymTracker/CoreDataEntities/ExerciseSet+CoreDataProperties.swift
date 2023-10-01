//
//  ExerciseSet+CoreDataProperties.swift
//  GymTracker
//
//  Created by Aleksandr Riakhin on 10/1/23.
//
//

import Foundation
import CoreData


extension ExerciseSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseSet> {
        return NSFetchRequest<ExerciseSet>(entityName: "ExerciseSet")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var index: Int16
    @NSManaged public var reps: Int16
    @NSManaged public var weight: Double
    @NSManaged public var exercise: Exercise?
}

extension ExerciseSet : Identifiable {

}
