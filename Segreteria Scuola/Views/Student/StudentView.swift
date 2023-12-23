//
//  StudentView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import SwiftUI

struct StudentView: View {
    var student: Student

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    CircleAvatarView(urlString: student.avatar)
                        .frame(width: 100, height: 100)
                    Spacer()
                }
                
                if let name = student.name {
                    Text(name)
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                if let email = student.email {
                    Text(email)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let classroom = student.classroom {
                    VStack(alignment: .leading) {
                        Text("Class:")
                            .font(.headline)
                            .padding(.bottom, 5)

                        Text(classroom)
                    }
                }
                
                if let notes = student.notes {
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .font(.headline)
                            .padding(.bottom, 5)

                        Text(notes)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Student detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    StudentView(student: .mock)
}
