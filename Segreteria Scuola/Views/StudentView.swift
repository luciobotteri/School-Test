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
                // Immagine dello Studente (se disponibile)
                HStack {
                    CircleAvatarView(urlString: student.avatar)
                        .frame(width: 100, height: 100)
                    Spacer()
                }

                // Nome (se disponibile)
                if let name = student.name {
                    Text(name)
                        .font(.title)
                        .fontWeight(.bold)
                }

                // Email (se disponibile)
                if let email = student.email {
                    Text(email)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Classe (se disponibile)
                if let classroom = student.classroom {
                    VStack(alignment: .leading) {
                        Text("Classe:")
                            .font(.headline)
                            .padding(.bottom, 5)

                        Text(classroom)
                    }
                }

                // Note (se disponibili)
                if let notes = student.notes {
                    VStack(alignment: .leading) {
                        Text("Note:")
                            .font(.headline)
                            .padding(.bottom, 5)

                        Text(notes)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Dettagli Studente")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    StudentView(student: .mock)
}
