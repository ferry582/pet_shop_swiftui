//
//  APIServiceAddFavoriteResponseFailureMock.swift
//  Pet ShopTests
//
//  Created by Ferry Dwianta P on 24/04/24.
//

#if DEBUG
import Foundation

class APIServiceAddFavoriteResponseFailureMock: APIService {
    func makeRequest<T>(session: URLSession, for endpoint: any Pet_Shop.Endpoint) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkError.duplicateFavorite
    }
    
    func makeRequest<T>(session: URLSession, for endpoint: any Pet_Shop.Endpoint) async throws -> (data: T, totalData: Int) where T : Decodable, T : Encodable {
        throw NetworkError.duplicateFavorite
    }
}
#endif
