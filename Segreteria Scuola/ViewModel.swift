//
//  ViewModel.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import Foundation

@Observable
final class ViewModel {
    var classrooms = [Classroom]()
    
    func fetchClassrooms() async {
        do {
            classrooms = try await NetworkManager.shared.fetchClassrooms()
        } catch {
            print(error)
        }
    }
}

extension ViewModel {
    static func withMocks(_ numberOfClassrooms: Int) -> ViewModel {
        let vm = ViewModel()
        for _ in 0..<numberOfClassrooms {
            vm.classrooms.append(.mock)
        }
        return vm
    }
}
