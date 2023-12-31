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
    @Query(sort: \.name, order: .forward) var allTags: [Tag]
    @State var noteText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a note") {
                    TextField("Enter Text", text: $noteText, axis: .vertical)
                        .lineLimit(2...4)
                    DisclosureGroup("Tags With") {
                        if allTags.isEmpty {
                            Text("You Don't have any tags 🔖")
                                .foregroundStyle(Color.gray)
                        }
                        ForEach(allTags) { tag in
                            HStack {
                                Text(tag.name)
                                
                                if tag.isChecked {
                                    Spacer()
                                    Image(systemName: "checkmark.circle")
                                        .symbolRenderingMode(.multicolor)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                tag.isChecked.toggle()
                            }
                        }
                    }
                    Button(action: {
                        creteNote()
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
                            
                            if note.tags.count > 0 {
                                HStack {
                                    Text("Tags:")
                                        .font(.caption)
                                    Text("#" + note.tags.map { $0.name }.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundStyle(Color.mint)
                                }
                            }
                            Text(note.createdAt, style: .time)
                                .font(.caption)
                        }
                    }
                    .onDelete{ indexSet in
                        indexSet.forEach { index in
                            context.delete(allNotes[index])
                        }
                        try? context.save()
                    }
                }
            }
        }
    }
    func creteNote() {
        var tags: [Tag] = []
        allTags.forEach { tag in
            if tag.isChecked {
                tags.append(tag)
                tag.isChecked = false
            }
        }
        
        let note = Note(id: UUID().uuidString, content: noteText, createdAt: .now, tags: tags)
        context.insert(note)
        try? context.save()
        noteText = ""
    }
    
}

#Preview {
    NoteListView()
}
