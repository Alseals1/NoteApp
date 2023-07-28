//
//  Filters.swift
//  NoteApp
//
//  Created by Alandis Seals on 7/28/23.
//

import Foundation
enum NoteSortBy: Identifiable, CaseIterable {
    var id: Self { self }
    case  createdby
    case content
    
    var text: String {
        switch self {
            case .createdby: return "Created at"
            case .content: return "Content"
        }
    }
}

enum OrderBy: Identifiable, CaseIterable {
    var id: Self { self }
    case ascending
    case descending
    
    var text: String {
        switch self {
            case .ascending:  return "Ascending"
            case .descending: return "Descending"
        }
    }
}
