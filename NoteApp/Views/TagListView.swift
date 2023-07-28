//
//  TagListView.swift
//  NoteApp
//
//  Created by Alandis Seals on 7/28/23.
//

import SwiftUI
import SwiftData

struct TagListView: View {
    /*To manage instances of your model classes at runtime, use a model context - the object responsible for the in-memory model data and coordination with the model container to successfully persist that data. To get a context for your model container that's bound to the main actor, use the mode1Context environment variable: */
    @Environment(\.modelContext) var context
    @Query(sort: \.name, order: .forward) var allTags: [Tag]
    @State var tagText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a tag") {
                    TextField("Enter Text", text: $tagText, axis: .vertical)
                        .lineLimit(2...4)
                    
                    Button(action: {
                        creteTag()
                    }, label: {
                        Text("Save")
                    })
                }
            }
            Section {
                if allTags.isEmpty {
                    ContentUnavailableView("You don't have any notes right now 🤔", systemImage: "note")
                } else {
                    ForEach(allTags) { tag in
                        if tag.notes.count > 0 {
                            DisclosureGroup("\(tag.name) (\(tag.notes.count))") {
                                ForEach(tag.notes) { note in
                                    Text(note.content)
                                }
                                .onDelete { indexSet in
                                    indexSet.forEach { index in
                                        context.delete(tag.notes[index])
                                    }
                                    try? context.save()
                                }
                            }
                        } else {
                            Text(tag.name)
                        }
                    }
                    .onDelete{ indexSet in
                        indexSet.forEach { index in
                            context.delete(allTags[index])
                        }
                        try? context.save()
                    }
                }
            }
        }
    }
    func creteTag() {
        let tag = Tag(id: UUID().uuidString, name: tagText, notes: [])
        context.insert(tag)
        try? context.save()
        tagText = ""
    }
}

#Preview {
    TagListView()
}
