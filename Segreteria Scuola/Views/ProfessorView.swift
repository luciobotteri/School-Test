//
//  ProfessorView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import SwiftUI

struct ProfessorView: View {
    
    var professor: Professor
    
    @State var isExpanded = false
    
    @Namespace private var animationNamespace

    var body: some View {
        VStack(alignment: .leading) {
            Text("Professore")
                .font(.title).bold()
                .foregroundColor(.green)
                .fontDesign(.rounded)
            
            HStack(spacing: 10) {
                CircleAvatarView(urlString: professor.avatar)
                    .frame(width: isExpanded ? 100 : 50, height: isExpanded ? 100 : 50)
                if !isExpanded {
                    professorDetails
                        .matchedGeometryEffect(id: "professorDetails", in: animationNamespace)
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
                professorDetails
                    .matchedGeometryEffect(id: "professorDetails", in: animationNamespace)
                    .padding(.top)
                expandedContent
                    .padding(.top)
            }
        }
        .navigationTitle("Dettagli professore")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var professorDetails: some View {
        VStack(alignment: .leading) {
            Text(professor.name ?? "No name")
                .font(.title2)
                .bold()
            if isExpanded, let email = professor.email, let url = URL(string: "mailto:"+email) {
                Link(email, destination: url)
                    .font(.title3)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.1)
            }
            if !isExpanded {
                Text(professor.email ?? "Email non presente")
                    .foregroundStyle(.secondary)
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
    VStack {
        ProfessorView(professor: .mock)
        Divider().padding()
        ProfessorView(professor: .mock, isExpanded: true)
    }.padding()
}
