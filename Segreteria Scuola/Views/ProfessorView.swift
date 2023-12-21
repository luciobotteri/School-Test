//
//  ProfessorView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import SwiftUI

struct ProfessorView: View {
    var professor: Professor

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Immagine del Professore
                CircleAvatarView(urlString: professor.avatar)
                    .frame(maxWidth: 150, maxHeight: 150)

                // Nome
                Text(professor.name ?? "Name")
                    .font(.title)
                    .fontWeight(.bold)

                // Email
                Text(professor.email ?? "Email")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // Materie insegnate
                VStack(alignment: .leading) {
                    Text("Materie Insegnate:")
                        .font(.headline)
                        .padding(.bottom, 5)

                    ForEach(professor.subjects ?? [], id: \.self) { subject in
                        Text(subject)
                            .padding(.vertical, 3)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Dettagli Professore")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ProfessorView(professor: .mock)
}
