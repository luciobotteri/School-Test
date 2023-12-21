//
//  Professor.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import Foundation

struct Professor: Codable {
    var _id: String
    var name: String?
    var email: String?
    var subjects: [String]?
    var avatar: String?
}

extension Professor {
    static var mock = Professor(_id: "ID", name: "Lucio", email: "luciobotteri@gmail.com", subjects: ["History", "English"], avatar: "https://api.multiavatar.com/Giulio%20Sforza.png")
}
