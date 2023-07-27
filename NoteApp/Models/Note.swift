//
//  Note.swift
//  NoteApp
//
//  Created by Alandis Seals on 7/27/23.
//

import Foundation
import SwiftData

@Model
class Note {
    @Attribute(.unique) var id: String
    
    var content: String
    var createdAt: Date
    @Relationship(inverse: \Tag.note) var tags: [Tag]
    
    init(id: String, content: String, createdAt: Date) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
    }
    
}
