//
//  APIServicePetsResponseSuccessMock.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 24/04/24.
//

import Foundation

#if DEBUG
import Foundation

class APIServicePetsResponseSuccessMock: APIService {
    let mockTotalPetsExist = 100
    
    func makeRequest<T>(session: URLSession, for endpoint: any Pet_Shop.Endpoint) async throws -> T where T : Decodable, T : Encodable {
        if case let PetAPI.pets(_, page) = endpoint, page == 0 {
            return try StaticJSONMapper.decode(file: "PetsDataPageOne", type: [Pet].self) as! T
        } else {
            return try StaticJSONMapper.decode(file: "PetsDataPageTwo", type: [Pet].self) as! T
        }
    }
    
    func makeRequest<T>(session: URLSession, for endpoint: any Pet_Shop.Endpoint) async throws -> (data: T, totalData: Int) where T : Decodable, T : Encodable {
        return (try StaticJSONMapper.decode(file: "PetsDataPageOne", type: [Pet].self) as! T, mockTotalPetsExist)
    }
}
#endif
