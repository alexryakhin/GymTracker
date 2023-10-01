//
//  ContentView.swift
//  GymTracker
//
//  Created by Aleksandr Riakhin on 10/1/23.
//

import SwiftUI
import CoreData

struct WorkoutsListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.timestamp, ascending: true)],
        animation: .default)
    private var workouts: FetchedResults<Workout>

    var body: some View {
        NavigationStack {
            List {
                ForEach(workouts) { workout in
                    NavigationLink {
                        WorkoutDetailsView(workout: workout)
                            .environment(\.managedObjectContext, viewContext)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(workout.name ?? "Workout")
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                            Text(workout.timestamp!, formatter: itemFormatter)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Gym Tracker")
        }
    }

    private func addItem() {
        withAnimation {
            let newWorkout = Workout(context: viewContext)
            newWorkout.timestamp = Date()
            newWorkout.name = "New workout"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { workouts[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()
