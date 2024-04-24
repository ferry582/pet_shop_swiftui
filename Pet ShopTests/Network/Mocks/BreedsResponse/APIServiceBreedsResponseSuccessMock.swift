//
//  APIServiceBreedsResponseSuccesMock.swift
//  Pet ShopTests
//
//  Created by Ferry Dwianta P on 24/04/24.
//

import Foundation
@testable import Pet_Shop

class APIServiceBreedsResponseSuccessMock: APIService {
    let mockTotalBreedsExist = 100
    
    func makeRequest<T>(session: URLSession, for endpoint: any Pet_Shop.Endpoint) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "BreedsData", type: [Breed].self) as! T
    }
    
    func makeRequest<T>(session: URLSession, for endpoint: any Pet_Shop.Endpoint) async throws -> (data: T, paginationCount: Int) where T : Decodable, T : Encodable {
        return (try StaticJSONMapper.decode(file: "BreedsData", type: [Breed].self) as! T, mockTotalBreedsExist)
    }
}
