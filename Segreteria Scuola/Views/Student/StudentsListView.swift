//
//  StudentsListView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 22/12/23.
//

import SwiftUI

struct StudentsListView: View {
    
    @Binding var students: [Student]
    var isEditable = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Students")
                .font(.title).bold()
                .foregroundColor(.orange)
                .padding(.bottom, 10)
            
            ForEach(students.indices, id: \.self) { i in
                if isEditable {
                    studentRow(i)
                } else {
                    StudentRowView(student: students[i])
                }
            }
        }
    }
    
    private func studentRow(_ i: Int) -> some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundColor(.orange)
            Text(students[i].name ?? "No name")
            Spacer()
            Button(role: .destructive) {
                students.remove(at: i)
            } label: {
                Image(systemName: "trash")
            }
        }
        .font(.title2)
        .padding(.bottom, 10)
    }
}

#Preview {
    VStack {
        StudentsListView(students: .constant([.mock, .mock, .mock, .mock])).padding(.bottom)
        StudentsListView(students: .constant([.mock]), isEditable: true)
    }.padding()
}
