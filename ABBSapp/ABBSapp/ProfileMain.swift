//
//  ProfileMain.swift
//  ABBSapp
//
//  Created by Cecilia on 4/24/25.
//

import SwiftUI
import Foundation


struct ProfileView: View {
    @State private var isEditProfilePresented = false
    @State private var isRandomProfilePresented = false
    @State private var profile = UserProfile(
        name: "Elon Musk",
        location: "Lives in Berkeley",
        introduction: "-",
        preferredMeetingTimes: [],
        grade: [],
        typeOfClasses: [],
        raceEthnicity: [],
        gender: []
    )

    var body: some View {
        VStack(spacing: 24) {
            
            // MARK: - Top ABBS Logo
            HStack {
                Image("ABBSLogo")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.leading, 16)
                Spacer()
            }
            .padding(.top, -40)
            
            // MARK: - Profile Picture + Edit Button
            ZStack(alignment: .bottomLeading) {
                Image("PFPCubstart")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2).frame(width: 180, height: 180))
                
                Button(action: {
                    isEditProfilePresented = true
                }) {
                    VStack(spacing: 4) {
                        Image("EditLogo")
                            .resizable()
                            .frame(width: 80, height: 80)
                        
                    }
                }
                .offset(x: -80, y: 25)
            }
            .padding(.top, -60)
            
            // MARK: - Name and Location
            Text(profile.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, -30)
            
            HStack(spacing: 4) {
                Image(systemName: "house.fill")
                Text(profile.location)
                    .foregroundColor(.gray)
            }
            .padding(.top, -20)
            
            // MARK: - Info Box
            ScrollView {
            VStack {
                    VStack(alignment: .leading, spacing: 60) {
                        Text("Introduction:\n\(profile.introduction)").lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Preferred Meeting Times: \(profile.preferredMeetingTimes.joined(separator: ", "))").lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Grade: \(profile.grade.joined(separator: ", "))").lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Type of Classes: \(profile.typeOfClasses.joined(separator: ", "))").lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Race/Ethnicity: \(profile.raceEthnicity.joined(separator: ", "))").lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Gender: \(profile.gender.joined(separator: ", "))").lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }}
            .frame(maxWidth: 300, alignment: .leading)
            .font(.system(size: 16))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
            .padding(.horizontal, 24)

            // MARK: - Bottom Tab Bar
            HStack {
                Spacer()
                Button(action: {
                    // Navigate to Profile Page
                    isRandomProfilePresented = true
                }) {
                    Image("SearchLogo")
                        .resizable()
                    .frame(width: 60, height: 60)}
                Spacer()
                Image("LikesLogo")
                    .resizable()
                    .frame(width: 90, height: 60)
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                    Image("ProfileLogo")
                        .resizable()
                        .frame(width: 43, height: 43)
                }
                Spacer()
            }
            .padding(.horizontal, -20)
            .padding(.bottom, -20)
        }
        .fullScreenCover(isPresented: $isEditProfilePresented) {
            EditProfile(profile: $profile)
        }
        .fullScreenCover(isPresented: $isRandomProfilePresented) {
            RandomProfileView()
        }
    }
}

#Preview {
    ProfileView()
}
