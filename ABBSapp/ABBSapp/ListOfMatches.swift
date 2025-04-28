//
//  ListOfMatches.swift
//  ABBSapp
//
//  Created by Cecilia on 4/28/25.
//


import SwiftUI

struct ListofMatches: View {
    @Binding var likedProfiles: [UserProfile]
    @State private var isProfilePresented = false
    @State private var isLikedProfilesPresented = false

    var body: some View {
        VStack {
            Text("Liked Profiles")
                .font(.largeTitle)
                .padding(.top, 20)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(Array(likedProfiles.enumerated()), id: \.element.name) { index, profile in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(profile.name)
                                .font(.title3)
                            Text("Classes: \(profile.typeOfClasses.joined(separator: ", "))")
                                .font(.body)
                                .foregroundColor(.gray)
                            Text("Instagram: \(profile.instagram)")
                                .font(.body)
                                .foregroundColor(.gray)
                            Text("LinkedIn: \(profile.linkedin)")
                                .font(.body)
                                .foregroundColor(.blue)
                                .underline()
                        }
                        .padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .contextMenu {
                            Button(role: .destructive) {
                                likedProfiles.remove(at: index)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 80)  // Add bottom padding so content doesn't overlap tab bar
            }
            
        }
    }
    
}

#Preview {
    ListofMatches(likedProfiles: .constant([
        UserProfile.randomProfile(),
        UserProfile.randomProfile(),
        UserProfile.randomProfile()
    ]))
}
