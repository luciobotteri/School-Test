//
//  HeaderView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 21/12/23.
//

import SwiftUI

struct HeaderView: View {
    
    @Environment(ViewModel.self) private var viewModel
    
    @Binding var selectedIndex: Int?
    @Binding var showAddClassroom: Bool
    @Binding var showSearch: Bool
    
    var body: some View {
        ZStack {
            Wave()
                .fill(CustomColor.header)
                .ignoresSafeArea()
                .padding(.bottom)
            HStack(spacing: 2) {
                if selectedIndex != nil {
                    Button {
                        withAnimation {
                            selectedIndex = nil
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }.transition(.move(edge: .leading).combined(with: .opacity))
                }
                Spacer()
                Text(titleString).bold()
                    .minimumScaleFactor(0.1)
                    .contentTransition(.numericText())
                if selectedIndex != nil {
                    Spacer()
                } else {
                    Text("rooms").fontWeight(.light)
                        .transition(.move(edge: .trailing).combined(with: .scale))
                    Spacer()
                }
            }
            .padding(.vertical, 30)
            .font(.largeTitle).padding()
            .fontDesign(.rounded)
            .foregroundStyle(Color(white: 0.95))
            HStack {
                Spacer()
                if selectedIndex == nil {
                    Menu {
                        Button {
                            showAddClassroom = true
                        } label: {
                            Label("Add new classroom", systemImage: "plus")
                        }
                        Button {
                            showSearch = true
                        } label: {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                        Button(role: .destructive) {
                            showAddClassroom = true
                        } label: {
                            Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title).padding().fontWeight(.semibold)
                            .fontDesign(.rounded)
                            .foregroundStyle(Color(white: 0.95))
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                }
            }
        }
        .frame(height: 80).padding(.bottom, 30)
    }
    
    private var titleString: String {
        if let i = selectedIndex {
            viewModel.classrooms[i]._id
        } else {
            "Class"
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        HeaderView(selectedIndex: .constant(nil), showAddClassroom: .constant(false), showSearch: .constant(false))
        HeaderView(selectedIndex: .constant(0), showAddClassroom: .constant(false), showSearch: .constant(false))
    }.environment(ViewModel.withMocks(1))
}
