//
//  WorkoutDetailsView.swift
//  GymTracker
//
//  Created by Aleksandr Riakhin on 10/1/23.
//

import SwiftUI
import CoreData

struct WorkoutDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddingAlert = false
    @State private var alertInput = ""

    @State private var isAddingSet: Bool = false
    @State private var reps = ""
    @State private var weight = ""

    @State private var editingExercise: Exercise?

    var workout: Workout

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.timestamp, ascending: true)],
        animation: .default)
    private var exercises: FetchedResults<Exercise>

    var body: some View {
        VStack {
            List {
                ForEach(exercises.filter({
                    $0.workout == workout
                })) { exercise in
                    exerciseSection(for: exercise)
                }
            }
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        showingAddingAlert.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .alert("Add an exercise", isPresented: $showingAddingAlert) {
                TextField("Enter exercise name", text: $alertInput)
                Button("Add", action: addExercise)
            } message: {
                Text("Enter exercise name")
            }
        }
        .navigationTitle(workout.name ?? "Workout")
    }

    private func exerciseSection(for exercise: Exercise) -> some View {
        Section {
            if exercise.sets_.isEmpty {
                Button {
                    withAnimation {
                        editingExercise = exercise
                        isAddingSet.toggle()
                    }
                } label: {
                    Text("Add a set")
                }
                .foregroundStyle(.primary)
            }
            ForEach(exercise.sets_) { set in
                VStack {
                    Text("Set #\(set.index + 1), reps \(set.reps)")
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                }
            }
            .onDelete(perform: deleteItems)
            if isAddingSet, editingExercise == exercise {
                TextField("Enter reps", text: $reps)
                TextField("Enter weight", text: $weight)
                Button {
                    withAnimation {
                        addSet(to: exercise)
                        editingExercise = nil
                        isAddingSet.toggle()
                    }
                } label: {
                    Text("Save")
                }
            }
        } header: {
            Text(exercise.name_)
        } footer: {
            if !exercise.sets_.isEmpty, !isAddingSet {
                Button {
                    withAnimation {
                        editingExercise = exercise
                        isAddingSet.toggle()
                    }
                } label: {
                    Text("Add a set")
                }
                .foregroundStyle(.primary)
            }
        }
    }

    private func addExercise() {
        let newExercise = Exercise(context: viewContext)
        newExercise.index = Int16(workout.exericises_.count)
        newExercise.timestamp = Date()
        newExercise.name = alertInput.isEmpty ? nil : alertInput
        withAnimation(.easeInOut) {
            workout.addToExercises(newExercise)
            saveContext()
            alertInput = ""
        }
    }

    private func addSet(to exercise: Exercise) {
        let newSet = ExerciseSet(context: viewContext)
        newSet.index = Int16(exercise.sets_.count)
        newSet.reps = Int16(reps) ?? 0
        newSet.weight = Double(weight) ?? 0
        newSet.timestamp = Date()
        withAnimation(.easeInOut) {
            exercise.addToSets(newSet)
            saveContext()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
