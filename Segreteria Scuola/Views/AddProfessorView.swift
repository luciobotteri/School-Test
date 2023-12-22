//
//  AddProfessorView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 22/12/23.
//

import SwiftUI

struct AddProfessorView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var professor: Professor?
    
    @State private var name = ""
    @State private var email = ""
    @State private var avatar: String? = ""
    @State private var subjects = ["String"]
    
    private var title: String {
        if let professor {
            "Edit professor " + (professor.name ?? professor._id)
        } else {
            "Add Professor"
        }
    }
    
    private var emailIsValid: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }
    
    private var professorIsValid: Bool {
        !name.isEmpty &&
        emailIsValid &&
        !subjects.isEmpty &&
        !subjects.map(\.count).contains(0)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.background2.gradient)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    avatarView
                        .padding(.top)
                    fields
                    Spacer()
                }
            }
            .scrollIndicators(.never)
            .scrollBounceBehavior(.basedOnSize)
            .safeAreaInset(edge: .bottom) {
                saveButton
            }
        }.onAppear {
            name = professor?.name ?? ""
            email = professor?.email ?? ""
            avatar = professor?.avatar
        }.navigationTitle(title)
    }
    
    @ViewBuilder private var avatarView: some View {
        if let avatar {
            CircleAvatarView(urlString: avatar)
                .frame(width: 150, height: 150)
                .onTapGesture {
                    changeAvatar()
                }
        } else {
            Button {
                changeAvatar()
            } label: {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .font(.largeTitle)
            }.foregroundStyle(.primary)
        }
    }
    
    private var fields: some View {
        VStack(alignment: .leading) {
            CustomField(field: $name, title: "Name")
            CustomField(field: $email, title: "Email", isValid: emailIsValid || email.isEmpty)
            ForEach($subjects.indices, id: \.self) { i in
                HStack(alignment: .lastTextBaseline) {
                    CustomField(field: $subjects[i], title: "Subject \(i+1)")
                    Button(role: .destructive) {
                        subjects.remove(at: i)
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            Button {
                subjects.append("")
                
            } label: {
                Label("Add new subject", systemImage: "plus")
            }
        }
        .font(.title3)
        .padding()
    }
    
    private var saveButton: some View {
        Button {
            professor = Professor(
                _id: UUID().uuidString,
                name: name.trimmingCharacters(in: .whitespaces),
                email: email.filter { !$0.isWhitespace },
                subjects: subjects,
                avatar: avatar
            )
            dismiss.callAsFunction()
        } label: {
            HStack {
                Spacer()
                Text("Save")
                    .frame(height: 35)
                    .font(.title3)
                    .fontDesign(.rounded)
                    .bold()
                Spacer()
            }
        }
        .buttonStyle(.borderedProminent)
        .disabled(!professorIsValid)
        .padding()
    }
    
    private func changeAvatar() {
        avatar = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            avatar = "https://api.multiavatar.com/\(name.filter { !$0.isWhitespace })\(Int.random(in: 0...99)).png"
        }
    }
}

#Preview {
    @State var professor: Professor?
    return NavigationView {
        AddProfessorView(professor: $professor)
    }
}

#Preview {
    @State var professor: Professor? = .mock
    return NavigationView {
        AddProfessorView(professor: $professor)
    }
}
