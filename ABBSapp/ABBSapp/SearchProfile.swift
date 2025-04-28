//
//  SearchProfile.swift
//  ABBSapp
//
//  Created by Cecilia on 4/27/25.
//

import SwiftUI

struct RandomProfileView: View {
    @State private var currentProfile: UserProfile = UserProfile.randomProfile()
    @Binding var likedProfiles: [UserProfile]
    @State private var isFilterPresented = false
    @State private var isProfilePresented = false
    @State private var isLikedProfilesPresented = false

    var body: some View {
        VStack(spacing: 16) {
            // Top Bar: ABBS Logo + Filter + Liked Profiles Button
            HStack {
                Image("ABBSLogo")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.leading, 16)
                Spacer()
                Button(action: {
                    isFilterPresented = true
                }) {
                    Text("Filter")
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .padding(.trailing, 16)
            }
            .padding(.top, -40)
            Spacer()

            // Profile Card
            ScrollView {
                VStack(spacing: 12) {
                    VStack(spacing: 12) {
                        Text(currentProfile.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "house.fill")
                            Text("Lives in \(currentProfile.location)")
                                .foregroundColor(.gray)
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Group {
                                profileInfo(label: "Introduction", content: currentProfile.introduction)
                                profileInfo(label: "Preferred Meeting Times", content: currentProfile.preferredMeetingTimes.joined(separator: ", "))
                                profileInfo(label: "Grade", content: currentProfile.grade.joined(separator: ", "))
                                profileInfo(label: "Type of Classes", content: currentProfile.typeOfClasses.joined(separator: ", "))
                                profileInfo(label: "Race/Ethnicity", content: currentProfile.raceEthnicity.joined(separator: ", "))
                                profileInfo(label: "Gender", content: currentProfile.gender.joined(separator: ", "))
                                profileInfo(label: "Instagram", content: currentProfile.instagram)
                                profileInfo(label: "LinkedIn", content: currentProfile.linkedin, link: true)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.horizontal, 24)
                }
            }

            // Like and Dislike Buttons
            HStack {
                Button(action: {
                    currentProfile = UserProfile.randomProfile()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 60, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }

                Spacer()

                Button(action: {
                    likedProfiles.append(currentProfile)
                    currentProfile = UserProfile.randomProfile()
                }) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 60, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 8)

            // Bottom Tab Bar
        }
        .fullScreenCover(isPresented: $isFilterPresented) {
            FilterPageView()
        }
        .fullScreenCover(isPresented: $isProfilePresented) {
            ProfileView(profile: .constant(UserProfile.randomProfile()), onEditProfile: {})
        }
        .fullScreenCover(isPresented: $isLikedProfilesPresented) {
            ListofMatches(likedProfiles: $likedProfiles)
        }
    }

    @ViewBuilder
    private func profileInfo(label: String, content: String, link: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("**\(label):**")
            if link {
                Text(content)
                    .foregroundColor(.blue)
                    .underline()
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                Text(content)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

