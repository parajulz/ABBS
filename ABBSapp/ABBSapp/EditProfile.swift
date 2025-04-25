//
//  EditProfile.swift
//  ABBSapp
//
//  Created by Cecilia on 4/24/25.
//

import SwiftUI
import PhotosUI

struct EditProfile: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var profile: UserProfile

    @State private var localProfile: UserProfile
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var showPhotoSourceDialog = false
    @State private var useCamera = false

    let filterGrades = ["Freshman", "Sophomore", "Junior", "Senior"]
    let filterClassTypes = ["CS", "EE", "DS", "Math", "Arts", "Chem", "Physics", "Business", "Other"]
    let filterEthnicities = [
        "American Indian/Alaska Native", "Hispanic or Latino", "White",
        "Native Hawaiian/Other Pacific Islander", "Black or African American", "Asian"
    ]
    let filterGenders = ["Male", "Female", "Other"]

    init(profile: Binding<UserProfile>) {
        self._profile = profile
        self._localProfile = State(initialValue: profile.wrappedValue)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {

                    // MARK: - Top Bar
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.uturn.backward")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Button(action: {
                            profile = localProfile
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("SAVE")
                                .font(.system(size: 30, weight: .heavy))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, -40)

                    // MARK: - Profile Image + Title
                    VStack(spacing: 6) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                        } else {
                            Image("PFPCubstart")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2).frame(width: 180, height: 180))
                        }

                        Text("EDIT PROFILE")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, -45)

                    // MARK: - Form Fields
                    VStack(spacing: 14) {
                        CustomTextField(title: "Introduction", content: $localProfile.introduction, isMultiline: true)

                        MultiSelectDropdown(title: "Preferred Meeting Times", options: ["Morning", "Afternoon", "Evening"], selection: $localProfile.preferredMeetingTimes)
                        MultiSelectDropdown(title: "Grade", options: filterGrades, selection: $localProfile.grade)
                        MultiSelectDropdown(title: "Type of Classes", options: filterClassTypes, selection: $localProfile.typeOfClasses)

                        HStack(spacing: 12) {
                            MultiSelectDropdown(title: "Race/Ethnicity", options: filterEthnicities, selection: $localProfile.raceEthnicity)
                            MultiSelectDropdown(title: "Gender", options: filterGenders, selection: $localProfile.gender)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
                .confirmationDialog("Select Photo Source", isPresented: $showPhotoSourceDialog) {
                    Button("Camera") {
                        useCamera = true
                        showImagePicker = true
                    }
                    Button("Photo Library") {
                        useCamera = false
                        showImagePicker = true
                    }
                    Button("Cancel", role: .cancel) {}
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: useCamera ? .camera : .photoLibrary, selectedImage: $selectedImage)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct CustomTextField: View {
    var title: String
    @Binding var content: String
    var isMultiline: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
            if isMultiline {
                TextEditor(text: $content)
                    .frame(height: 100)
                    .padding(8)
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(8)
            } else {
                TextField("Type here...", text: $content)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(8)
            }
        }
    }
}

struct MultiSelectDropdown: View {
    let title: String
    let options: [String]
    @Binding var selection: [String]
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)

            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(selection.isEmpty ? "Select" : selection.joined(separator: ", "))
                        .foregroundColor(selection.isEmpty ? .gray : .black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(10)
                .frame(height: 40)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(8)
            }

            if isExpanded {
                VStack(spacing: 4) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            if selection.contains(option) {
                                selection.removeAll { $0 == option }
                            } else {
                                selection.append(option)
                            }
                        }) {
                            HStack {
                                Image(systemName: selection.contains(option) ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.blue)
                                Text(option)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4))
                )
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

