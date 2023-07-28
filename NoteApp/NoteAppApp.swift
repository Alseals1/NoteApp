//
//  NoteAppApp.swift
//  NoteApp
//
//  Created by Alandis Seals on 7/27/23.
//

import SwiftUI
import SwiftData

@main
struct NoteAppApp: App {
    
    @State var noteSearchText: String = ""
    @State var noteSortBy = NoteSortBy.createdby
    @State var noteOrderBy = OrderBy.descending
    
    @State var tageSearcgText = ""
    @State var tagOrderBy = OrderBy.ascending
    
    var body: some Scene {
        WindowGroup {
            TabView {
                noteList
                tagList
            }
            .modelContainer(for: [Note.self, Tag.self])
            /*To set up the default storage, use the modelContainer (for: inMemory: isAutosaveEnabled:is UndoEnabled: onSetup:) view modifier (or the scene equivalent) and specify the array of model types to persist. If you use the view modifier, add it at the very top of the view hierarchy so all nested views inherit the properly configured environment:*/
        }
    }
    
    var noteListQuery: Query<Note, [Note]> {
        let sortOrder: SortOrder = noteOrderBy == .ascending ? .forward : .reverse
        var predicate: Predicate<Note>?
        if !noteSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(#Predicate { $0.content.contains(noteSearchText) })
        }
        if noteSortBy == .content {
            return Query(filter: predicate, sort: \.content, order: sortOrder)
        } else {
            return Query(filter: predicate, sort: \.createdAt, order: sortOrder)
        }
    }
    
    var noteList: some View {
        NavigationStack {
            NoteListView(allNotes: noteListQuery)
                .searchable(text: $noteSearchText, prompt: "Search")
                .textInputAutocapitalization(.never)
                .navigationTitle("Notes")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
                            Picker("Sort By", selection: $noteOrderBy) {
                                ForEach(NoteSortBy.allCases) {
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(noteOrderBy.text, systemImage: "line.horizontal.3.decrease.circle")
                        }

                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Order By", selection: $noteOrderBy) {
                                ForEach(OrderBy.allCases) {
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(noteSortBy.text, systemImage: "arrow.up.arrow.down")
                        }

                    }
                    
                }
        }
        .tabItem { Label("Notes", systemImage: "note") }
    }
    
    var tagList: some View {
        NavigationStack {
            TagListView()
                .navigationTitle("Tags")
        }
        .tabItem { Label("Tag", systemImage: "tag") }
    }
}
