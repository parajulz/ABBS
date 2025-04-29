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

    @State private var filterSettings = FilterSettings()

    var body: some View {
        VStack(spacing: 16) {
            // Top Bar: ABBS Logo + Filter Button
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
                .padding(.trailing, 24)
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
                    generateNewProfile()
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
                    generateNewProfile()
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
        }
        .fullScreenCover(isPresented: $isFilterPresented) {
            FilterPageView(filterSettings: $filterSettings)
        }
    }

    // MARK: - Helper Functions

    private func generateNewProfile() {
        var newProfile: UserProfile
        repeat {
            newProfile = UserProfile.randomProfile()
        } while !matchesFilters(profile: newProfile)
        currentProfile = newProfile
    }

    private func matchesFilters(profile: UserProfile) -> Bool {
        if !filterSettings.meetingTimes.isEmpty &&
            profile.preferredMeetingTimes.allSatisfy({ !filterSettings.meetingTimes.contains($0) }) {
            return false
        }
        if !filterSettings.grades.isEmpty &&
            profile.grade.allSatisfy({ !filterSettings.grades.contains($0) }) {
            return false
        }
        if !filterSettings.classTypes.isEmpty &&
            profile.typeOfClasses.allSatisfy({ !filterSettings.classTypes.contains($0) }) {
            return false
        }
        if !filterSettings.ethnicities.isEmpty &&
            profile.raceEthnicity.allSatisfy({ !filterSettings.ethnicities.contains($0) }) {
            return false
        }
        if !filterSettings.genders.isEmpty &&
            profile.gender.allSatisfy({ !filterSettings.genders.contains($0) }) {
            return false
        }
        return true
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
