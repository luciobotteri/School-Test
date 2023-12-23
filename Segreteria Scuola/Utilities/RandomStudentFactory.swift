//
//  RandomStudentFactory.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 22/12/23.
//

import Foundation

enum RandomStudentFactory {
    static func make(classroom: String? = nil) -> Student {
        let name = names.randomElement()!
        let surname = surnames.randomElement()!
        let email = name.filter { $0.isLetter }.lowercased() + symbols.randomElement()! + surname.filter { $0.isLetter }.lowercased() + "@gmail.com"
        
        return Student(_id: UUID().uuidString,
                       name: name + " " + surname,
                       email: email,
                       avatar: nil,
                       notes: adverbs.randomElement()! + " " + adjectives.randomElement()!,
                       classroom: classroom)
    }
    
    private static let names = [
        "Liam",
        "Olivia",
        "Lucio",
        "Emma",
        "Oliver",
        "Charlotte",
        "James",
        "Amelia",
        "Steve",
        "Sophia",
        "William",
        "Isabella",
        "Henry",
        "Ava",
        "Lucas",
        "Mia",
        "Benjamin",
        "Evelyn",
        "Theodore",
        "Luna"
    ]
    
    private static let surnames = [
        "Rodriguez",
        "Simpson",
        "Griffin",
        "McDonald",
        "Jobs",
        "Botteri",
        "Kvaratskhelia",
        "Alighieri",
        "Armstrong",
        "Hendryx",
        "O' Connor",
        "Jordison",
        "Kraftwerk",
        "Bauhaus",
        "Einstein",
        "Cage",
        "Truman",
        "Musk",
        "De Filippo",
        "Davey"
    ]
    
    private static let symbols = ["", "-", "_", "."]
    
    private static let adverbs = [
        "Molto",
        "Abbastanza",
        "Poco",
        "Discretamente",
        "Sufficientemente",
        "Incredibilmente"
    ]
    
    private static let adjectives = [
        "bravo",
        "attento",
        "interessato agli argomenti",
        "perspicace",
        "pigro"
    ]
}
