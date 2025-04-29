//
//  ListOfMatches.swift
//  ABBSapp
//
//  Created by Cecilia on 4/28/25.
//
import SwiftUI
import SwiftData

struct ListofMatches: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var likedProfiles: [UserProfile]

    var body: some View {
        VStack {
            Text("Liked Profiles")
                .font(.largeTitle)
                .padding(.top, 20)
            
            List {
                ForEach(likedProfiles) { profile in
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
                    .padding(35)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)  // <--- Draw box
                    )
                    .listRowSeparator(.hidden) // <--- Hide default list separators
                    .padding(.vertical, 8)      // <--- Add spacing between boxes
                }
                .onDelete(perform: deleteProfile)
            }
            .listStyle(PlainListStyle()) // <--- Make the list plain
        }
    }
    
    private func deleteProfile(at offsets: IndexSet) {
        for index in offsets {
            let profileToDelete = likedProfiles[index]
            modelContext.delete(profileToDelete)
        }
        likedProfiles.remove(atOffsets: offsets)
    }
}

#Preview {
    ListofMatches(likedProfiles: .constant([
        UserProfile.randomProfile(),
        UserProfile.randomProfile(),
        UserProfile.randomProfile()
    ]))
}
