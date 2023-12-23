//
//  StudentRowView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 23/12/23.
//

import SwiftUI

struct StudentRowView: View {
    
    let student: Student
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            studentRow
            if isExpanded {
                HStack {
                    expandedContent
                    Spacer()
                }.transition(
                    .move(edge: .top)
                    .combined(with: .scale)
                    .combined(with: .opacity)
                )
            }
        }
    }
    
    private var studentRow: some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundColor(.orange)
            Text(student.name ?? "No name")
            Spacer()
            Image(systemName: "chevron.right")
                .rotationEffect(isExpanded ? .init(degrees: 90) : .zero)
        }
        .font(.title2)
        .padding(.bottom, 10)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
    
    private var expandedContent: some View {
        VStack(alignment: .leading) {
            if let email = student.email, let url = URL(string: "mailto:"+email) {
                Link(email, destination: url)
                    .font(.title3)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.1)
                    .padding(.bottom)
            }
            if let notes = student.notes {
                Text("Notes:")
                    .font(.headline)
                    .padding(.bottom, 5)
                Text(notes)
                    .padding(.bottom)
            }
            Divider()
                .padding(.bottom)
        }
    }
}

#Preview {
    StudentsListView(students: .constant([.mock, .mock, .mock, .mock])).padding(.bottom)
        .padding()
}
