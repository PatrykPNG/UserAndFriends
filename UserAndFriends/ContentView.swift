//
//  ContentView.swift
//  UserAndFriends
//
//  Created by Patryk Ostrowski on 27/02/2025.
//

import SwiftData
import SwiftUI


//zrobic funkcje formattedRegistered
struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]

    @State private var isLoading = true
    
    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView("Loading users..")
                    .progressViewStyle(.circular)
            } else {
                List(users) { user in
                    HStack {
                        VStack(alignment: .leading) {
                            NavigationLink(value: user) {
                                VStack(alignment: .leading) {
                                    Text(user.name)
                                        .font(.headline)
                                    
                                    Text("age: \(user.age)")
                                        .font(.subheadline)
                                }
                            }
                        }
                        VStack {
                            Text(user.isActive ? "Active" : "Offline")
                                .font(.subheadline)
                                .foregroundStyle(user.isActive ? .green : .red)
                        }
                    }
                }
                .navigationTitle("UserAndFriends")
                .navigationDestination(for: User.self) { user in
                    DetailView(user: user)
                }
            }
        }
        .task {
            await loadData()
            print(users.count)
        }
    }
    
    func loadData() async {
        await fetchData()
        isLoading = false
    }
    
    func fetchData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            try modelContext.delete(model: User.self)
        } catch {
            print("Failed to delete all Users.")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //tutaj mozliwe ze bede musial zmienic
            let decodedUsers = try decoder.decode([User].self, from: data)
            for user in decodedUsers {
                modelContext.insert(user)
            }

            
             
        } catch {
            print("invalid data \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
