//
//  ClassroomDetailView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import SwiftUI

struct ClassroomDetailView: View {
    
    @Environment(ViewModel.self) private var viewModel
    
    var classroom: Classroom
    @Binding var selectedIndex: Int?
    
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var showEditClassroom = false
    @State private var showingDeleteAlert = false
    @State private var offset: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Room: " + (classroom.roomName ?? "201"))
                        .font(.title).bold().fontDesign(.rounded)
                        .padding(.vertical)
                    Spacer()
                }
                professorView
                studentsList
                    .padding(.top)
                Spacer()
                editButton
                    .padding(.bottom)
                if isLoading {
                    ProgressView()
                } else {
                    deleteButton
                }
            }
            .padding()
        }
        .offset(x: offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.spring()) {
                        offset = value.translation.width
                    }
                    if offset > 60 {
                        withAnimation {
                            selectedIndex = nil
                        }
                    }
                }
                .onEnded { value in
                    withAnimation(.spring()) {
                        offset = .zero
                    }
                }
        )
        .fullScreenCover(isPresented: $showEditClassroom) {
            AddClassroomView(classroomToEdit: classroom)
        }
    }
    
    @ViewBuilder private var professorView: some View {
        if let professor = classroom.professor {
            ProfessorView(professor: professor)
        } else {
            Text("Nessun professore assegnato a questa classe.")
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder private var studentsList: some View {
        if let students = classroom.students, !students.isEmpty {
            VStack(alignment: .leading) {
                Text("Studenti")
                    .font(.title).bold()
                    .foregroundColor(.orange)
                    .padding(.bottom, 10)
                
                ForEach(students, id: \._id) { student in
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.orange)
                        Text(student.name ?? "No name")
                    }
                    .font(.title2)
                    .padding(.bottom, 10)
                }
            }
        } else {
            Text("Nessuno studente assegnato a questa classe.")
                .foregroundColor(.secondary)
        }
    }
    
    private var editButton: some View {
        Button {
            showEditClassroom = true
        } label: {
            Label("Edit classroom", systemImage: "pencil")
                .font(.headline)
        }.buttonStyle(.borderedProminent)
    }
    
    private var deleteButton: some View {
        VStack {
            if let errorMessage {
                Text(errorMessage)
            }
            Button(role: .destructive) {
                showingDeleteAlert = true
            } label: {
                Label("Delete classroom", systemImage: "trash")
                    .font(.headline)
            }
        }.alert("Are you sure?", isPresented: $showingDeleteAlert) {
            Button(role: .destructive) {
                isLoading = true
                Task {
                    do {
                        try await NetworkManager.shared.deleteClassroom(classroom)
                        await viewModel.fetchClassrooms()
                        withAnimation {
                            selectedIndex = nil
                        }
                    } catch {
                        isLoading = false
                    }
                }
            } label: {
                Text("Delete classroom \(classroom._id)")
            }
            Button("Cancel", role: .cancel) {
                showingDeleteAlert = false
            }
        }
    }
}


#Preview {
    ClassroomDetailView(classroom: .mock, selectedIndex: .constant(nil))
        .environment(ViewModel.withMocks(2))
}
