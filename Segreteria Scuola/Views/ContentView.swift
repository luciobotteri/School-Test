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
    @State private var showSearch = false
    @State private var showAddClassroom = false
    @State private var isAnimating = false
    @State private var bounceValue: Int = 0
    
    @Namespace private var animationNamespace
    
    private var classrooms: [Classroom] {
        viewModel.classrooms
    }
    
    var body: some View {
        ZStack {
            listOrDetailView
                .safeAreaPadding(.top, 120)
            VStack {
                HeaderView(selectedIndex: $selectedIndex, showAddClassroom: $showAddClassroom, showSearch: $showSearch)
                Spacer()
            }
        }.background {
            Color.background.ignoresSafeArea()
        }.fullScreenCover(isPresented: $showAddClassroom) {
            AddClassroomView()
        }.sheet(isPresented: $showSearch) {
            SearchView()
        }.onAppear {
            if classrooms.isEmpty {
                Task {
                    await viewModel.fetchClassrooms()
                }
            }
        }
    }
    
    @ViewBuilder private var listOrDetailView: some View {
        if classrooms.isEmpty {
            noDataView
        } else if let i = selectedIndex, i < classrooms.count {
            ClassroomDetailView(classroom: classrooms[i], selectedIndex: $selectedIndex)
                .transition(.move(edge: .trailing).combined(with: .opacity))
        } else {
            ClassroomsListView(selectedIndex: $selectedIndex)
                .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }
    
    @ViewBuilder private var noDataView: some View {
        ScrollView {
        }.refreshable {
            Task {
                await viewModel.fetchClassrooms()
            }
        }
        VStack {
            Image(systemName: "tray")
                .font(.system(size: 80))
                .padding(.bottom)
            Text("No classrooms yet")
                .font(.headline)
                .fontDesign(.rounded)
        }.foregroundStyle(.header)
        VStack(alignment: .trailing) {
            HStack {
                Spacer()
                Image(systemName: "arrow.up")
                    .font(.largeTitle).bold()
                    .symbolEffect(.pulse, options: .repeating, isActive: true)
            }.padding(.horizontal, 15)
            Text("Start from here")
                .font(.headline)
                .fontDesign(.rounded)
                .padding(.horizontal)
            Spacer()
        }
        .foregroundStyle(.header)
        .offset(y: -25)
    }
}

#Preview {
    ContentView()
        .environment(ViewModel.withMocks(0))
}
