//
//  APIError.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 17/04/24.
//

import Foundation

enum NetworkError: Error {
    case unabeToGenerateRequest
    case invalidEndpoint
    case parsingError
}

struct APIService {
    
    func makeRequest<T: Codable>(for endpoint: Endpoint) async throws -> T {
        guard let request = endpoint.generateURLRequest() else {
            throw NetworkError.unabeToGenerateRequest
        }
        
        let response = try? await URLSession.shared.data(for: request)
        guard let response = response else {
            throw NetworkError.invalidEndpoint
        }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: response.0)
            return result
        } catch {
            print(error)
            throw NetworkError.parsingError
        }
    }
}
