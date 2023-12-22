//
//  AddClassroomView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 21/12/23.
//

import SwiftUI

struct AddClassroomView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Environment(ViewModel.self) private var viewModel
    
    @State private var id = ""
    @State private var name = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var professor: Professor?
    
    var classroomToEdit: Classroom?
    
    private var classroomIsReadyToBeSaved: Bool {
        !id.isEmpty &&
        !name.isEmpty &&
        professor != nil
    }
    
    private var title: String {
        if let classroomToEdit {
            "Edit classroom "+classroomToEdit._id
        } else {
            "Add Classroom"
        }
    }
    
    var body: some View {
        NavigationStack {
            scrollContent
                .navigationTitle(title)
        }.onAppear {
            copyDataFromClassroomToEdit()
        }.onChange(of: id) { _, newValue in
            id = id.filter { !$0.isWhitespace }
        }.tint(.indigo)
    }
    
    private var scrollContent: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CustomField(field: $id, title: "ID")
                CustomField(field: $name, title: "Name")
                professorField
            }
        }
        .font(.title3)
        .fontWeight(.medium)
        .scrollBounceBehavior(.basedOnSize)
        .scrollIndicators(.never)
        .padding()
        .background(Color.background2.gradient)
        .safeAreaInset(edge: .bottom) {
            bottomButtons
        }
    }
    
    @ViewBuilder private var professorField: some View {
        let title = professor == nil ? "Add professor" : "Edit professor"
        if let professor {
            Text("Professor: " + (professor.name ?? professor._id))
                .padding(.bottom)
        }
        NavigationLink {
            AddProfessorView(professor: $professor)
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
    }
    
    private var studentField: some View {
        NavigationLink {
            AddStudentView()
        } label: {
            HStack {
                Text("Add professor")
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
    }
    
    @ViewBuilder private var bottomButtons: some View {
        if isLoading {
            ProgressView()
                .padding(30)
        } else {
            VStack {
                if let errorMessage {
                    Text(errorMessage)
                }
                HStack {
                    cancelButton
                    saveButton
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
    }
    
    private var saveButton: some View {
        Button {
            isLoading = true
            Task {
                do {
                    try await NetworkManager.shared.createClassroom(
                        Classroom(_id: id, roomName: name)
                    )
                    await viewModel.fetchClassrooms()
                    dismiss.callAsFunction()
                } catch {
                    isLoading = false
                    errorMessage = "An error occurred. Please try again."
                }
            }
        } label: {
            HStack {
                Spacer()
                Text("Save")
                    .frame(height: 35)
                    .font(.title3)
                    .fontDesign(.rounded)
                    .bold()
                Spacer()
            }
        }
        .disabled(!classroomIsReadyToBeSaved)
    }
    
    private var cancelButton: some View {
        Button {
            dismiss.callAsFunction()
        } label: {
            HStack {
                Spacer()
                Text("Cancel")
                    .frame(height: 35)
                    .font(.title3)
                    .fontDesign(.rounded)
                    .bold()
                Spacer()
            }
        }.tint(.brown)
    }
    
    private func copyDataFromClassroomToEdit() {
        if let classroomToEdit {
            id = classroomToEdit._id
            name = classroomToEdit.roomName ?? ""
            professor = classroomToEdit.professor
        }
    }
}

#Preview {
    AddClassroomView()
        .environment(ViewModel.withMocks(2))
}

#Preview {
    AddClassroomView(classroomToEdit: .mock)
        .environment(ViewModel.withMocks(2))
}
