//
//  NoteListView.swift
//  NoteApp
//
//  Created by Alandis Seals on 7/27/23.
//

import SwiftUI
import SwiftData

struct NoteListView: View {
    
    /*To manage instances of your model classes at runtime, use a model context - the object responsible for the in-memory model data and coordination with the model container to successfully persist that data. To get a context for your model container that's bound to the main actor, use the mode1Context environment variable: */
    @Environment(\.modelContext) var context
    @Query(sort: \.createdAt, order: .reverse) var allNotes: [Note]
    @State var noteText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a note") {
                    TextField("Enter Text", text: $noteText, axis: .vertical)
                        .lineLimit(2...4)
                    
                    Button(action: {
                        creteNote()
                        noteText = ""
                    }, label: {
                        Text("Save")
                    })
                }
            }
            Section {
                if allNotes.isEmpty {
                    ContentUnavailableView("You don't have any notes right now 🤔", systemImage: "note")
                } else {
                    ForEach(allNotes) { note in
                        VStack(alignment: .leading) {
                            Text(note.content)
                            Text(note.createdAt, style: .time)
                                .font(.caption)
                        }
                    }
                    .onDelete{ indexSet in
                        indexSet.forEach { index in
                            context.delete(allNotes[index])
                        }
                        //try? context.save()
                    }
                }
            }
        }
    }
    func creteNote() {
        let note = Note(id: UUID().uuidString, content: noteText, createdAt: .now)
        context.insert(note)
        try? context.save()
    }
    
}

#Preview {
    NoteListView()
}
