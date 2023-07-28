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
    
    var noteList: some View {
        NavigationStack {
            NoteListView()
                .navigationTitle("Notes")
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
