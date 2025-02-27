//
//  ContentView.swift
//  UserAndFriends
//
//  Created by Patryk Ostrowski on 27/02/2025.
//

import SwiftUI

struct User: Codable {
    var name: String
    var age: Int
    var company: String
//    var friends: [Friend]
}

struct Friend: Codable {
    var id: String
    var name: String
}

struct ContentView: View {
//    @State private var friends = [Friend]()
    @State private var users = [User]()
    
    var body: some View {
        List(users, id: \.age) { item in
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //more code
        } catch {
            print("invalid data")
        }
    }
}

#Preview {
    ContentView()
}
