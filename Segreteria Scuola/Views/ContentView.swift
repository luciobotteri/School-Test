//
//  ContentView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(ViewModel.self) private var viewModel
    
    @State private var selectedIndex: Int?
    @State private var isAnimating = false
    
    @Namespace private var animationNamespace
    
    private var classrooms: [Classroom] {
        viewModel.classrooms
    }
    
    var body: some View {
        ZStack {
            listOrDetailView
                .safeAreaPadding(.top, 120)
            VStack {
                headerView
                Spacer()
            }
        }.background {
            CustomColor.background.ignoresSafeArea()
        }.onAppear {
            if classrooms.isEmpty {
                Task {
                    await viewModel.fetchClassrooms()
                }
            }
        }
    }
    
    @ViewBuilder private var listOrDetailView: some View {
        if let i = selectedIndex {
            ClassroomDetailView(classroom: classrooms[i])
                .transition(.move(edge: .trailing).combined(with: .opacity))
        } else {
            ClassroomsListView(selectedIndex: $selectedIndex)
                .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }
    
    private var headerView: some View {
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
                    Spacer()
                }
                Text(titleString).bold()
                    .minimumScaleFactor(0.1)
                    .contentTransition(.numericText())
                if selectedIndex != nil {
                    Spacer()
                } else {
                    Text("rooms").fontWeight(.light)
                        .transition(.move(edge: .trailing).combined(with: .scale))
                }
            }
            .font(.largeTitle).padding()
            .fontDesign(.rounded)
            .foregroundStyle(Color(white: 0.95))
            .padding(.vertical, 30)
        }.frame(height: 80).padding(.bottom, 30)
    }
    
    private var titleString: String {
        if let i = selectedIndex {
            classrooms[i]._id
        } else {
            "Class"
        }
    }
}

#Preview {
    ContentView()
        .environment(ViewModel.withMocks(12))
}
