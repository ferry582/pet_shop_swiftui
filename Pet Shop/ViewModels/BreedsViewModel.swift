//
//  BreedsViewModel.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 17/04/24.
//

import Foundation

class BreedsViewModel: ObservableObject {
    @Published private(set) var breeds = [Breed]()
    @Published private(set) var isLoading = false
    @Published private(set) var isFetching = false
    @Published private(set) var alertMessage = ""
    @Published var isAlertActive = false
    
    private var page = 0
    private var service = APIService()
    private var totalData = 0
    
    @MainActor
    func getBreedsData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result: (data: [Breed], paginationCount: Int) = try await service.makeRequest(for: PetAPI.breeds(page: page))
            self.breeds = result.data
            self.totalData = result.paginationCount
        } catch {
            isAlertActive = true
            alertMessage = (error as? NetworkError)?.description ?? "Network Error! Something went wrong"
            print(error)
        }
    }
    
    @MainActor
    func getNextBreedsData() async {
        guard !(breeds.count >= totalData) else {
            return
        }
        
        isFetching = true
        defer { isFetching = false }
        
        page += 1
        
        do {
            let result: [Breed] = try await service.makeRequest(for: PetAPI.breeds(page: page))
            self.breeds += result
        } catch {
            isAlertActive = true
            alertMessage = (error as? NetworkError)?.description ?? "Network Error! Something went wrong"
            print(error)
        }
    }
    
    @MainActor
    func getBreedImageData(petId: String) async -> String {
        do {
            let result: Pet = try await service.makeRequest(for: PetAPI.pet(petId: petId))
            return result.url
        } catch {
            isAlertActive = true
            alertMessage = (error as! NetworkError).description
            return ""
        }
    }
    
    func hasReachedEnd(of breed: Breed) -> Bool {
        breeds.last?.id == breed.id
    }
    
    func refreshedTriggered() {
        breeds.removeAll()
        page = 0
        totalData = 0
    }
}
