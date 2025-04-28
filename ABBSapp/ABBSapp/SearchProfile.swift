//
//  SearchProfile.swift
//  ABBSapp
//
//  Created by Cecilia on 4/27/25.
//

import SwiftUI

struct RandomProfileView: View {
    @State private var currentProfile: UserProfile = UserProfile.randomProfile()
    @State private var isFilterPresented = false
    @State private var isProfilePresented = false


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
                        .padding(.trailing, 24)
                }
            }
            .padding(.top, -40)
            Spacer()


            // Profile Card with BOX
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
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("**Introduction:**")
                                    Text(currentProfile.introduction)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("**Preferred Meeting Times:**")
                                    Text(currentProfile.preferredMeetingTimes.joined(separator: ", "))
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("**Grade:**")
                                    Text(currentProfile.grade.joined(separator: ", "))
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("**Type of Classes:**")
                                    Text(currentProfile.typeOfClasses.joined(separator: ", "))
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("**Race/Ethnicity:**")
                                    Text(currentProfile.raceEthnicity.joined(separator: ", "))
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("**Gender:**")
                                    Text(currentProfile.gender.joined(separator: ", "))
                                        .fixedSize(horizontal: false, vertical: true)
                                }
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

            // Bottom Tab Bar (same as you posted)
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                    Image("SearchLogo")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                Spacer()
                Image("LikesLogo")
                    .resizable()
                    .frame(width: 90, height: 60)
                Spacer()
                Button(action: {
                    // Navigate to Profile Page
                    isProfilePresented = true
                }) {
                    Image("ProfileLogo")
                        .resizable()
                        .frame(width: 43, height: 43)
                }
                Spacer()
            }
            .padding(.horizontal, -20)
            .padding(.bottom, -20)
        }
        .fullScreenCover(isPresented: $isFilterPresented) {
            FilterPageView()
        }
        .fullScreenCover(isPresented: $isProfilePresented) {
            ProfileView()
        }
    }
}

#Preview {
    RandomProfileView()
}
