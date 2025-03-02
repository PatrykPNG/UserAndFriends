//
//  UserAndFriendsApp.swift
//  UserAndFriends
//
//  Created by Patryk Ostrowski on 27/02/2025.
//

import SwiftUI

@main
struct UserAndFriendsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
