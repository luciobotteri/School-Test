//
//  ProfessorView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import SwiftUI

struct ProfessorView: View {
    
    var professor: Professor
    
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Professore")
                .font(.title).bold()
                .foregroundColor(.green)
                .fontDesign(.rounded)
            
            HStack(spacing: 10) {
                CircleAvatarView(urlString: professor.avatar)
                    .frame(width: isExpanded ? 80 : 50, height: isExpanded ? 80 : 50)
                VStack(alignment: .leading) {
                    Text(professor.name ?? "No name")
                        .font(.title2)
                        .bold()
                    Text(professor.email ?? "Email non presente")
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .rotationEffect(isExpanded ? .init(degrees: 90) : .zero)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                expandedContent
                    .padding(.top)
            }
        }
    }
    
    @ViewBuilder private var expandedContent: some View {
        let subjects = professor.subjects?.joined(separator: ", ") ?? "Nessuna"
        VStack(alignment: .leading) {
            Text("Materie Insegnate:")
                .font(.headline)
                .padding(.bottom, 5)
            Text(subjects + ".")
        }
    }
}


#Preview {
    ProfessorView(professor: .mock)
        .padding()
}
