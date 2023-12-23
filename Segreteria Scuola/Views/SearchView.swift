//
//  SearchView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 22/12/23.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(ViewModel.self) private var viewModel
    @State private var searchText = ""
    @State private var searchIsActive = true
    
    private var professors: [Professor] {
        viewModel.classrooms
            .compactMap { $0.professor }
    }
    
    private var filteredProfessors: [Professor] {
        if searchText.isEmpty { return professors }
        return professors.filter {
            if let name = $0.name, name.lowercased().contains(searchText.lowercased()) {
                return true
            }
            if let email = $0.email, email.lowercased().contains(searchText.lowercased()) {
                return true
            }
            return false
        }
    }
    
    private var students: [Student] {
        viewModel.classrooms
            .compactMap { $0.students }
            .reduce([]) { $0 + $1 }
    }
    
    private var filteredStudents: [Student] {
        if searchText.isEmpty { return students }
        return students.filter {
            if let name = $0.name, name.lowercased().contains(searchText.lowercased()) {
                return true
            }
            if let email = $0.email, email.lowercased().contains(searchText.lowercased()) {
                return true
            }
            return false
        }
    }
    
    var body: some View {
        NavigationView {
            if filteredProfessors.isEmpty, filteredStudents.isEmpty {
                ContentUnavailableView.search
            } else {
                List {
                    professorsSection
                    studentsSection
                }.headerProminence(.increased)
            }
        }.searchable(text: $searchText, isPresented: $searchIsActive)
    }
    
    @ViewBuilder private var professorsSection: some View {
        if !filteredProfessors.isEmpty {
            Section {
                ForEach(filteredProfessors, id: \._id) { prof in
                    NavigationLink {
                        VStack {
                            ProfessorView(professor: prof, isExpanded: true)
                            Spacer()
                        }.padding()
                    } label: {
                        Text(prof.name ?? prof._id)
                    }
                }
            } header: {
                Text("Professors")
            }
        }
    }
    
    @ViewBuilder private var studentsSection: some View {
        if !filteredStudents.isEmpty {
            Section {
                ForEach(filteredStudents, id: \._id) { student in
                    NavigationLink {
                        StudentView(student: student)
                            .padding()
                    } label: {
                        Text(student.name ?? student._id)
                    }
                }
            } header: {
                Text("Students")
            }
        }
    }
}

#Preview {
    SearchView()
        .environment(ViewModel.withMocks(9))
}
