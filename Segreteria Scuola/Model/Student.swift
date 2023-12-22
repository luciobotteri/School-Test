//
//  Student.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import Foundation

struct Student: Codable {
    var _id: String
    var name: String?
    var email: String?
    var avatar: String?
    var notes: String?
    var classroom: String?
}

extension Student {
    static var mock = Student(_id: "ID_\(Int.random(in: 0...9999))", name: "Lucio", email: "luciobotteri@gmail.com", avatar: nil, notes: "A nice guy", classroom: "C1")
}
