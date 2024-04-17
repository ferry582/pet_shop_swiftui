//
//  APICall.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 17/04/24.
//

import Foundation

enum PetAPI {
    case breeds(page: Int)
    case pet(petId: String)
}

extension PetAPI: Endpoint {
    private static var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "API-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'API-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'API-Info.plist'.")
        }
        return value
    }
    
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "api.thedogapi.com"
    }
    
    var path: String {
        switch self {
        case .breeds(_):
            return "/v1/breeds"
        case .pet(petId: let id):
            return "/v1/images/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .breeds(page: let page):
            return [
                URLQueryItem(name: "limit", value: String(10)),
                URLQueryItem(name: "page", value: String(page)),
            ]
        case .pet(_):
            return [
                URLQueryItem(name: "limit", value: String(PetAPI.apiKey))
            ]
        }
    }
    
    var method: String {
        return "get"
    }
    
    func generateURLRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
    
}
