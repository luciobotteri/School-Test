//
//  ClassroomsListView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 21/12/23.
//

import SwiftUI

struct ClassroomsListView: View {
    
    @Environment(ViewModel.self) private var viewModel
    @Binding var selectedIndex: Int?
    
    private var classrooms: [Classroom] {
        viewModel.classrooms
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(classrooms.indices, id: \.self) { i in
                    Button {
                        withAnimation {
                            selectedIndex = i
                        }
                    } label: {
                        ClassroomView(classroom: classrooms[i], colorIndex: i)
                            .frame(minHeight: 90)
                    }.foregroundStyle(.primary)
                }
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.never)
        .refreshable {
            Task {
                await viewModel.fetchClassrooms()
            }
        }
    }
}

#Preview {
    ClassroomsListView(selectedIndex: .constant(0))
        .environment(ViewModel.withMocks(4))
}
