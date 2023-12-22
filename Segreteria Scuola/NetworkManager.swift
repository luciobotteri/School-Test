//
//  NetworkManager.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 20/12/23.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = URL(string: "https://servicetest3.edo.io/school")
    
    private let apiKey = "f57ymABTwOYo"

    private init() {}

    func fetchClassrooms() async throws -> [Classroom] {
        guard let url = baseURL?.appendingPathComponent("classrooms") else { throw NSError() }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer "+apiKey, forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
        else {
            throw URLError(.badServerResponse)
        }
        
        let school = try JSONDecoder().decode(School.self, from: data)
        return school.classrooms
    }
    
    @discardableResult
    func createClassroom(_ classroom: Classroom) async throws -> Classroom {
        guard let url = baseURL?.appendingPathComponent("classroom/\(classroom._id)") else { throw NSError() }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer "+apiKey, forHTTPHeaderField: "Authorization")
        
        let jsonData = try JSONEncoder().encode(classroom)
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
        else {
            throw URLError(.badServerResponse)
        }
        
        let classroom = try JSONDecoder().decode(Classroom.self, from: data)
        return classroom
    }
    
    func deleteClassroom(_ classroom: Classroom) async throws {
        guard let url = baseURL?.appendingPathComponent("classroom/\(classroom._id)") else { throw NSError() }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer "+apiKey, forHTTPHeaderField: "Authorization")
        
        let jsonData = try JSONEncoder().encode(classroom)
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
        else {
            let errorData = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: errorData])
        }
    }
}
