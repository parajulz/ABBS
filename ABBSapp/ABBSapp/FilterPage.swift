//
//  FilterPage.swift
//  ABBSapp
//
//  Created by Cecilia on 4/27/25.
//

import SwiftUI

struct FilterOption: Identifiable {
    let id = UUID()
    let label: String
    var isSelected: Bool = false
}

struct FilterPageView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var meetingTimes = [
        FilterOption(label: "Morning"),
        FilterOption(label: "Afternoon"),
        FilterOption(label: "Evening")
    ]
    
    @State private var grades = [
        FilterOption(label: "Freshman"),
        FilterOption(label: "Sophomore"),
        FilterOption(label: "Junior"),
        FilterOption(label: "Senior")
    ]
    
    @State private var classTypes = [
        FilterOption(label: "CS"), FilterOption(label: "EE"), FilterOption(label: "DS"),
        FilterOption(label: "Math"), FilterOption(label: "Arts"), FilterOption(label: "Chem"),
        FilterOption(label: "Physics"), FilterOption(label: "Business"), FilterOption(label: "Other")
    ]
    
    @State private var ethnicities = [
        FilterOption(label: "American Indian/\nAlaska Native"),
        FilterOption(label: "Hispanic or Latino"),
        FilterOption(label: "White"),
        FilterOption(label: "Native Hawaiian/\nOther Pacific Islander"),
        FilterOption(label: "Black or African American"),
        FilterOption(label: "Asian")
    ]
    
    @State private var genders = [
        FilterOption(label: "Male"),
        FilterOption(label: "Female"),
        FilterOption(label: "Other")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    Text("FILTER")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    FilterSectionView(title: "Preferred Meeting Times", options: $meetingTimes)
                    FilterSectionView(title: "Grade", options: $grades)
                    FilterSectionView(title: "Type of Classes", options: $classTypes)
                    FilterSectionView(title: "Race/Ethnicity", options: $ethnicities, columns: 2)
                    FilterSectionView(title: "Gender", options: $genders)

                    Button("RESET") {
                        resetFilters()
                    }
                    .foregroundColor(.gray)
                    .padding(.top)
                }
                .padding()
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.black)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("SAVE") {
                        print("Filters saved.")
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }

    func resetFilters() {
        meetingTimes.indices.forEach { meetingTimes[$0].isSelected = false }
        grades.indices.forEach { grades[$0].isSelected = false }
        classTypes.indices.forEach { classTypes[$0].isSelected = false }
        ethnicities.indices.forEach { ethnicities[$0].isSelected = false }
        genders.indices.forEach { genders[$0].isSelected = false }
    }
}

struct FilterSectionView: View {
    let title: String
    @Binding var options: [FilterOption]
    var columns: Int = 2

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.medium)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: columns), spacing: 10) {
                ForEach(options.indices, id: \.self) { index in
                    Button(action: {
                        options[index].isSelected.toggle()
                    }) {
                        HStack {
                            Image(systemName: options[index].isSelected ? "checkmark.square" : "square")
                            Text(options[index].label)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}


#Preview {
    FilterPageView()
}
