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
    @State private var subjects = [String]()
    
    @FocusState private var focus: Int?
    
    private var title: String {
        if professor == nil {
            "Add Professor"
        } else {
            "Edit Professor"
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
            ScrollView {
                VStack {
                    avatarView
                        .padding(.top)
                    fields
                    Spacer()
                }.padding(.bottom, 60)
            }
            .scrollIndicators(.never)
            .scrollBounceBehavior(.basedOnSize)
            .background(Color.background.gradient)
            .safeAreaInset(edge: .bottom) {
                saveButton
                    .background(.thinMaterial)
            }
        }.onAppear {
            name = professor?.name ?? ""
            email = professor?.email ?? ""
            avatar = professor?.avatar
            subjects = professor?.subjects ?? []
        }.navigationTitle(title)
            .onTapGesture {
                focus = nil
            }
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
                .textContentType(.name)
                .focused($focus, equals: 0)
                .submitLabel(.next)
            CustomField(field: $email, title: "Email", isValid: emailIsValid || email.isEmpty)
                .textContentType(.emailAddress)
                .focused($focus, equals: 1)
                .submitLabel(.next)
            ForEach($subjects.indices, id: \.self) { i in
                HStack(alignment: .lastTextBaseline) {
                    CustomField(field: $subjects[i], title: "Subject \(i+1)")
                        .focused($focus, equals: i+2)
                        .submitLabel(i == subjects.count-1 ? .done : .next)
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
        .onSubmit {
            if let focus {
                self.focus = focus + 1
            }
        }
    }
    
    private var saveButton: some View {
        Button {
            professor = Professor(
                _id: UUID().uuidString,
                name: name.trimmingCharacters(in: .whitespaces),
                email: email.filter { !$0.isWhitespace },
                subjects: subjects.map { $0.trimmingCharacters(in: .whitespaces) },
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
