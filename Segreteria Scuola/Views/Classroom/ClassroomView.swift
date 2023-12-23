//
//  ClassroomView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import SwiftUI

struct ClassroomView: View {
    
    let classroom: Classroom
    let colorIndex: Int
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var color: Color {
        CustomColor.cell(colorIndex)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color.gradient)
                .aspectRatio(1, contentMode: .fit)
                .shadow(color: color.opacity(0.5), radius: 5, y: 5)
            
            VStack(alignment: .leading) {
                Text(classroom._id)
                    .font(.largeTitle)
                    .fontDesign(.rounded)
                    .bold()
                    .opacity(colorScheme == .dark ? 1 : 0.8)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                Text("Room " + (classroom.roomName ?? ""))
                    .font(.callout).fontWeight(.medium)
                    .opacity(0.9)
                    .multilineTextAlignment(.leading)
                Spacer()
                HStack {
                    Group {
                        Spacer()
                        if let professor = classroom.professor {
                            CircleAvatarView(urlString: professor.avatar)
                                .frame(width: 30)
                        }
                        ZStack {
                            Capsule()
                                .fill(Color.background)
                                .opacity(0.9)
                            studentsView
                        }.fixedSize(horizontal: true, vertical: false)
                    }.frame(height: 30)
                }
            }.padding()
        }
    }
    
    @ViewBuilder private var professorView: some View {
        if let professorName = classroom.professor?.name {
            Text("Professor: " + professorName)
        } else {
            Text("No professor")
        }
    }
    
    private var studentsView: some View {
        let studentsCount = classroom.students?.count ?? 0
        let symbol: String
        switch studentsCount {
        case 0: symbol = "person"
        case 1: symbol = "person.fill"
        case 2: symbol = "person.2.fill"
        default: symbol = "person.3.fill"
        }
        return Label("\(studentsCount)", systemImage: symbol)
            .fontWeight(.medium)
            .labelStyle(.titleAndIcon)
            .foregroundStyle(.primary)
            .padding(.horizontal)
    }
}

#Preview {
    ClassroomsListView(selectedIndex: .constant(nil))
        .environment(ViewModel.withMocks(6))
}
