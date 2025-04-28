//
//  user.swift
//  ABBSapp
//
//  Created by Cecilia on 4/24/25.
//
import SwiftUI
import Foundation

struct UserProfile {
    var name: String
    var location: String
    var introduction: String
    var preferredMeetingTimes: [String]
    var grade: [String]
    var typeOfClasses: [String]
    var raceEthnicity: [String]
    var gender: [String]
    
    static func randomProfile() -> UserProfile {
        let names = ["Anuska P.", "Ryan Wood", "Eunice Y.", "Thomas Jeff", "Maya Chen"]
        let locations = ["Berkeley", "San Francisco", "San Jose", "Oakland", "Sacramento"]
        let introductions = [
            "Big fan of working in libraries, let's connect!",
            "Hey Everyone! I'm Anuska, I go to UC Berkeley majoring in EECS.",
            "Looking for a morning study buddy!",
            "Love math and coffee, hit me up!",
            "New to campus, want to meet friends!"
        ]
        
        let meetingTimes = ["Morning", "Afternoon", "Evening"]
        let classTypes = ["CS", "EE", "DS", "Math", "Arts", "Chem", "Physics", "Business", "Other"]
        let ethnicities = [
            "American Indian/Alaska Native", "Hispanic or Latino", "White",
            "Native Hawaiian/Other Pacific Islander", "Black or African American", "Asian"
        ]
        let grades = ["Freshman", "Sophomore", "Junior", "Senior"]
        let genders = ["Male", "Female", "Other"]
        
        return UserProfile(
            name: names.randomElement() ?? "John Doe",
            location: locations.randomElement() ?? "Unknown",
            introduction: introductions.randomElement() ?? "Hello!",
            preferredMeetingTimes: Array(meetingTimes.shuffled().prefix(Int.random(in: 1...2))),  // pick 1-2 random
            grade: [grades.randomElement() ?? "Freshman"],        // ✅ ONLY 1 grade
            typeOfClasses: Array(classTypes.shuffled().prefix(Int.random(in: 1...3))), // pick 1-3
            raceEthnicity: Array(ethnicities.shuffled().prefix(Int.random(in: 1...2))), // pick 1-2
            gender: [genders.randomElement() ?? "Other"]          // ✅ ONLY 1 gender
        )
    }
}
