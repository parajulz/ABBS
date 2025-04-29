//
//  user.swift
//  ABBSapp
//
//  Created by Cecilia on 4/24/25.
//
import SwiftUI
import Foundation

struct UserProfile : Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var introduction: String
    var preferredMeetingTimes: [String]
    var grade: [String]
    var typeOfClasses: [String]
    var raceEthnicity: [String]
    var gender: [String]
    var instagram: String
    var linkedin: String
    
    static func randomProfile() -> UserProfile {
        let names = [
            "Anuska P.", "Ryan Wood", "Eunice Y.", "Thomas J.", "Maya Chen",
            "Liam Patel", "Sophia Lin", "Noah Kim", "Olivia G.", "Aiden Singh",
            "Emma Lopez", "Lucas Z.", "Isabella N.", "Mason Rivera", "Ava Johnson",
            "Ethan Park", "Mia M.", "James Lee", "Charlotte A.", "Benjamin F.",
            "Amelia B.", "Logan Torres", "Harper W.", "Elijah N.", "Ella Smith",
            "Alexander D.", "Scarlett Hall", "Jacob T.", "Lily Clark", "Michael S."
        ]

        let locations = [
            "Berkeley", "San Francisco", "San Jose", "Oakland", "Sacramento",
            "Davis", "Fremont", "Sunnyvale", "Palo Alto", "Santa Clara",
            "Mountain View", "Los Angeles", "Santa Cruz", "Irvine", "San Diego",
            "Pasadena", "Claremont", "Long Beach", "Santa Barbara", "Anaheim",
            "Cupertino", "Redwood City", "Menlo Park", "Emeryville", "Vallejo",
            "Concord", "Walnut Creek", "Pleasanton", "Hayward", "Millbrae"
        ]

        let introductions = [
            "Big fan of working in libraries, let's connect!",
            "Hey Everyone! I go to UC Berkeley majoring in EECS.",
            "Looking for a morning study buddy!",
            "Love math and coffee, hit me up!",
            "New to campus, want to meet friends!",
            "Always down to grind at Moffitt or Main Stacks.",
            "Introvert but friendly, let's study together!",
            "I enjoy coding, music, and spontaneous adventures.",
            "Hoping to meet people in my classes!",
            "Down for late-night problem-solving sessions.",
            "Into startups and entrepreneurship, let's chat!",
            "Happy to help with CS61A / CS70 material!",
            "Let's prep for exams together!",
            "Coffee + coding = perfect combo.",
            "Looking to improve my study habits.",
            "I love group projects and collabs!",
            "Chemistry major but love all things STEM.",
            "Trying to meet more people outside my major!",
            "Fluent in Python and sarcasm.",
            "Passionate about data science and visualizations!",
            "Gym rat but also bookworm.",
            "Open to both virtual and in-person sessions!",
            "Love learning languages and cultures.",
            "Let’s vibe over bubble tea study dates!",
            "CS + design enthusiast, hit me up!",
            "Always curious, always learning.",
            "Trying to survive upper-division classes!",
            "Aspiring researcher looking for peers!",
            "Study sessions + chill conversations = ideal.",
            "Let’s make studying fun!"
        ]

        let meetingTimes = [
                    "Morning", "Afternoon", "Evening"
                ]

                let classTypes = [
                    "CS", "EE", "DS", "Math", "Arts", "Chem", "Physics", "Business", "Other"
                ]

                let ethnicities = [
                    "American Indian/Alaska Native", "Hispanic or Latino", "White",
                    "Native Hawaiian/Other Pacific Islander", "Black or African American", "Asian"        ]

                let grades = [
                    "Freshman", "Sophomore", "Junior", "Senior",
                ]

                let genders = [
                    "Male", "Female", "Other",
                ]


        let chosenName = names.randomElement() ?? "John Doe"
        let (firstName, lastName) = parseName(chosenName)

        return UserProfile(
            name: chosenName,
            location: locations.randomElement() ?? "Unknown",
            introduction: introductions.randomElement() ?? "Hello!",
            preferredMeetingTimes: Array(meetingTimes.shuffled().prefix(Int.random(in: 1...2))),
            grade: [grades.randomElement() ?? "Freshman"],
            typeOfClasses: Array(classTypes.shuffled().prefix(Int.random(in: 1...3))),
            raceEthnicity: Array(ethnicities.shuffled().prefix(Int.random(in: 1...2))),
            gender: [genders.randomElement() ?? "Other"],
            instagram: "@\(firstName.lowercased())\(lastName.lowercased())",
            linkedin: "https://www.linkedin.com/in/\(firstName.lowercased())-\(lastName.lowercased())"
        )
    }
    
    private static func parseName(_ fullName: String) -> (String, String) {
        let parts = fullName.split(separator: " ")
        let first = parts.first.map(String.init) ?? "john"
        let last = parts.dropFirst().first.map { String($0.filter { $0.isLetter }) } ?? "doe"  // removes period
        return (first, last)
    }
}
