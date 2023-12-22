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
    @State private var showAddClassroom = false
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
                HeaderView(selectedIndex: $selectedIndex, showAddClassroom: $showAddClassroom)
                Spacer()
            }
        }.background {
            CustomColor.background.ignoresSafeArea()
        }.sheet(isPresented: $showAddClassroom) {
            AddClassroomView()
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
            ClassroomDetailView(classroom: classrooms[i], selectedIndex: $selectedIndex)
                .transition(.move(edge: .trailing).combined(with: .opacity))
        } else {
            ClassroomsListView(selectedIndex: $selectedIndex)
                .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }
}

#Preview {
    ContentView()
        .environment(ViewModel.withMocks(0))
}
