//
//  Friend.swift
//  UserAndFriends
//
//  Created by Patryk Ostrowski on 01/03/2025.
//

import Foundation
import SwiftData


class Friend: Codable, Identifiable {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
