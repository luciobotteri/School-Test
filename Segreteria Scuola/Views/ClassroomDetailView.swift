//
//  ClassroomDetailView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import SwiftUI

struct ClassroomDetailView: View {
    
    var classroom: Classroom

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack {
                    Text("Room: " + (classroom.roomName ?? "201"))
                        .font(.title)
                }

                // Dettagli del Professore
                if let professor = classroom.professor {
                    VStack(alignment: .leading) {
                        Text("Professore:")
                            .font(.headline)
                            .foregroundColor(.green)

                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.green)
                            Text(professor.name ?? "No name")
                            Spacer()
                        }
                    }
                }

                // Elenco Studenti
                if let students = classroom.students, !students.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Studenti:")
                            .font(.headline)
                            .foregroundColor(.orange)
                        
                        ForEach(students, id: \._id) { student in
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.orange)
                                Text(student.name ?? "No name")
                            }
                        }
                    }
                } else {
                    Text("Nessuno studente assegnato a questa classe.")
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .padding()
        }
    }
}


#Preview {
    ClassroomDetailView(classroom: .mock)
}
