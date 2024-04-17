//
//  BreedsViewModel.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 17/04/24.
//

import Foundation

class BreedsViewModel: ObservableObject {
    @Published var breeds = [Breed]()
    @Published var isLoading = false
    
    private var page = 0
    private var service = APIService()
    
    func getBreedsData() {
        isLoading = true
        Task.init {
            do {
                let result: [Breed] = try await service.makeRequest(for: PetAPI.breeds(page: 0))
                DispatchQueue.main.async {
                    self.breeds = result
                    self.isLoading = false
                }
            } catch {
                print("Error:", error)
                isLoading = false
            }
        }
    }
}
