//
//  ContentView.swift
//  ABBSapp
//
//  Created by Cecilia on 4/24/25.
//
import SwiftUI


enum Tab {
    case randomProfile
    case likedProfiles
    case profile
}

struct ContentView: View {
    @State private var currentTab: Tab = .randomProfile
    @State private var likedProfiles: [UserProfile] = []
    @State private var profile = UserProfile.randomProfile()
    @State private var isEditProfilePresented = false

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch currentTab {
                case .randomProfile:
                    RandomProfileView(likedProfiles: $likedProfiles)
                case .likedProfiles:
                    ListofMatches(likedProfiles: $likedProfiles)
                case .profile:
                    ProfileView(profile: $profile, onEditProfile: {
                        isEditProfilePresented = true
                    })
                }
            }
            .frame(maxHeight: .infinity)

            bottomTabBar
        }
        .fullScreenCover(isPresented: $isEditProfilePresented) {
            EditProfile(profile: $profile)
        }
    }

    private var bottomTabBar: some View {
        HStack {
            Spacer()
            Button(action: { currentTab = .randomProfile }) {
                ZStack {
                    if currentTab == .randomProfile {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 60)
                    }
                    Image("SearchLogo")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
            }
            Spacer()
            Button(action: { currentTab = .likedProfiles }) { ZStack {
                if currentTab == .likedProfiles {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                }
                Image("LikesLogo")
                    .resizable()
                    .frame(width: 90, height: 60)
            }
            }
            Spacer()
            Button(action: { currentTab = .profile }) {
                ZStack {
                    if currentTab == .profile {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 60)
                    }
                    Image("ProfileLogo")
                        .resizable()
                        .frame(width: 43, height: 43)
                }
            }
            Spacer()
        }
        .padding(.horizontal, -20)
        .padding(.bottom, -20)
    }
}

#Preview {
    ContentView()
}
