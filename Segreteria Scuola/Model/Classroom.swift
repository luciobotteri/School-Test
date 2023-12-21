//
//  Classroom.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import Foundation

struct Classroom: Codable {
    var _id: String
    var roomName: String?
    var students: [Student]?
    var professor: Professor?
    var school: String?
}

extension Classroom {
    static var mock: Classroom {
        Classroom(_id: "C\(Int.random(in: 1...9))", roomName: "\(Int.random(in: 100...999))", students: Array(repeating: .mock, count: Int.random(in: 0...5)), professor: .mock, school: "School")
    }
}
