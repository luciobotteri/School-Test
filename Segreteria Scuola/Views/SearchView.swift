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
            List {
                Section {
                    ForEach(filteredProfessors.indices, id: \.self) { i in
                        NavigationLink {
                            ProfessorView(professor: professors[i])
                                .padding()
                        } label: {
                            Text(professors[i].name ?? professors[i]._id)
                        }
                    }
                } header: {
                    Text("Professori")
                }
                Section {
                    ForEach(filteredStudents.indices, id: \.self) { i in
                        NavigationLink {
                            StudentView(student: students[i])
                                .padding()
                        } label: {
                            Text(students[i].name ?? students[i]._id)
                        }
                    }
                } header: {
                    Text("Studenti")
                }
            }
            .headerProminence(.increased)
            .searchable(text: $searchText, isPresented: $searchIsActive)
        }
    }
}

#Preview {
    SearchView()
        .environment(ViewModel.withMocks(9))
}
