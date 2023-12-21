//
//  StudentView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import SwiftUI

import SwiftUI

struct StudentView: View {
    var student: Student
    
    var avatarURL: URL? {
        URL(string: student.avatar ?? "")
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Immagine dello Studente (se disponibile)
                if let avatarURL {
                    AsyncImage(url: avatarURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.top, 20)
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
