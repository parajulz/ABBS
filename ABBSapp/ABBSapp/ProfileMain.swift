//
//  ProfileMain.swift
//  ABBSapp
//
//  Created by Cecilia on 4/24/25.
//
import SwiftUI
import Foundation

struct ProfileView: View {
    @Binding var profile: UserProfile
    var onEditProfile: () -> Void

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
                    onEditProfile()
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
                VStack(alignment: .leading, spacing: 60) {
                    Text("Introduction:\n\(profile.introduction)")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Preferred Meeting Times: \(profile.preferredMeetingTimes.joined(separator: ", "))")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Grade: \(profile.grade.joined(separator: ", "))")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Type of Classes: \(profile.typeOfClasses.joined(separator: ", "))")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Race/Ethnicity: \(profile.raceEthnicity.joined(separator: ", "))")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Gender: \(profile.gender.joined(separator: ", "))")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Instagram: \(profile.instagram)")
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("LinkedIn: \(profile.linkedin)")
                        .foregroundColor(.blue)
                        .underline()
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: 300, alignment: .leading)
                .font(.system(size: 16))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .padding(.bottom, 100) // Prevent bottom bar from overlapping
            }
        }
    }
}
