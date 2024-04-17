//
//  APIError.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 17/04/24.
//

import Foundation

enum NetworkError: Error {
    case unableToGenerateRequest
    case invalidEndpoint
    case parsingError
    
    var description: String {
        switch self {
        case .unableToGenerateRequest:
            return "Network Error! Unable to generate request"
        case .invalidEndpoint:
            return "Network Error! Invalid network adress"
        case .parsingError:
            return "Parsing Error! Errror occured when parsing data"
        }
    }
}

struct APIService {
    
    func makeRequest<T: Codable>(for endpoint: Endpoint) async throws -> T {
        guard let request = endpoint.generateURLRequest() else {
            throw NetworkError.unableToGenerateRequest
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
