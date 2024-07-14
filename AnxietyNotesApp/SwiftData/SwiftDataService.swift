//
//  SwiftDataSevice.swift
//  AnxietyNotesApp
//
//  Created by Anggara Satya Wimala Nelwan on 12/07/24.
//

import Foundation
import SwiftData

class SwiftDataService{
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Note.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchNotes() -> [Note] {
        var fetchDescriptor = FetchDescriptor<Note>()
        fetchDescriptor.sortBy = [SortDescriptor(\Note.date, order: .reverse)]
        
        do {
            return try modelContext.fetch(fetchDescriptor)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveNotes(note: Note){
        modelContext.insert(note)
    }
}