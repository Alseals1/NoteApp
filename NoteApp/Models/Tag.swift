//
//  Tag.swift
//  NoteApp
//
//  Created by Alandis Seals on 7/27/23.
//

import Foundation
import SwiftData

@Model
class Tag {
    @Attribute(.unique) var id: String
    var name: String
    
    //Automatically it will basically create the relationship the schema for us us under the hood
    //Default Relatiomship is ".nullify".
    @Relationship var note: [Note]
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
}
