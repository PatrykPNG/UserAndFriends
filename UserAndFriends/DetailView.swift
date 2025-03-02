//
//  DetailView.swift
//  UserAndFriends
//
//  Created by Patryk Ostrowski on 01/03/2025.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    
    
    let user: User
    
    var body: some View {
        List {
            Section {
                Text("Age: \(user.age)")
                Text("Work for: \(user.company)")
                Text("Email: \(user.email)")
                Text("Addres: \(user.address)")
                Text("Joined: \(formattedDate(user.registered))")
            } header: {
                Text("Basic info")
            }
            
            Section {
                Text(user.about)
            } header: {
                Text("About")
            }
            
            Section {
                Text("tags: \(user.tags)")
            } header: {
                Text("tags")
            }
            
            Section {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
                
            } header: {
                Text("User friends")
            }
        }
        .navigationTitle(user.name)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

//#Preview {
//    DetailView(user: User(id: UUID(), isActive: true, name: "akbar", age: 18, company: "Standis", email: "gargas@gmail.com", address: "Lipowa 12", about: "NIezly ziomek", registered: .now, tags: [], friends: []))
//}
