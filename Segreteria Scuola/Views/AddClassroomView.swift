//
//  AddClassroomView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 21/12/23.
//

import SwiftUI

struct AddClassroomView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Environment(ViewModel.self) private var viewModel
    
    @State private var id = "sadf"
    @State private var name = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Add Classroom").font(.largeTitle).bold().fontDesign(.rounded)
                    .padding(.bottom, 40)
                if !id.isEmpty {
                    Text("ID").font(.footnote).foregroundStyle(.secondary)
                }
                TextField("ID", text: $id)
                separator
                if !name.isEmpty {
                    Text("Name").font(.footnote).foregroundStyle(.secondary)
                }
                TextField("Name", text: $name)
                separator
            }
        }
        .font(.title3)
        .fontWeight(.medium)
        .scrollBounceBehavior(.basedOnSize)
        .scrollIndicators(.never)
        .padding()
        .background(Color.background2.gradient)
        .safeAreaInset(edge: .bottom) {
            if isLoading {
                ProgressView()
                    .padding(30)
            } else {
                VStack {
                    if let errorMessage {
                        Text(errorMessage)
                    }
                    Button {
                        isLoading = true
                        Task {
                            do {
                                try await NetworkManager.shared.createClassroom(
                                    Classroom(_id: id, roomName: name)
                                )
                                await viewModel.fetchClassrooms()
                                dismiss.callAsFunction()
                            } catch {
                                isLoading = false
                                errorMessage = "An error occurred. Please try again."
                            }
                        }
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
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .tint(.indigo)
                }
            }
        }
    }
    
    private var separator: some View {
        Rectangle()
            .fill(.secondary)
            .frame(height: 1)
            .padding(.bottom, 40)
    }
}

#Preview {
    AddClassroomView()
        .environment(ViewModel.withMocks(2))
}
