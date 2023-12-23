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
    @State private var students = [Student]()
    
    var classroomToEdit: Classroom?
    
    private var classroomIsValid: Bool {
        !id.isEmpty &&
        !name.isEmpty &&
        professor != nil &&
        !students.isEmpty
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
        }.onChange(of: id) {
            id = id.filter { !$0.isWhitespace }
        }.tint(.indigo)
    }
    
    private var scrollContent: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CustomField(field: $id, title: "ID")
                CustomField(field: $name, title: "Name")
                professorField
                    .padding(.bottom, 40)
                studentsField
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
            ProfessorView(professor: professor, isExpandable: false)
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
    
    @ViewBuilder private var studentsField: some View {
        StudentsListView(students: $students, isEditable: true)
        NavigationLink {
            AddStudentView()
        } label: {
            Button {
                students.append(.mock)
            } label: {
                Label("Add student", systemImage: "person.fill.badge.plus")
            }
        }
        .padding(.top)
        .padding(.bottom, 80)
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
                .padding([.bottom, .horizontal])
            }
        }
    }
    
    private var saveButton: some View {
        Button {
            isLoading = true
            Task {
                do {
                    if let classroomToEdit {
                        try await NetworkManager.shared.updateClassroom(classroom: Classroom(_id: classroomToEdit._id, roomName: name, students: students, professor: professor))
                    } else {
                        try await NetworkManager.shared.createClassroom(
                            Classroom(_id: id, roomName: name, students: students, professor: professor)
                        )
                    }
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
        .disabled(!classroomIsValid)
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
            students = classroomToEdit.students ?? []
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
