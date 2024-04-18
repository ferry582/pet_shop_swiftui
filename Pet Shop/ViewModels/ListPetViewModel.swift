//
//  ListPetViewModel.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 18/04/24.
//

import Foundation

class ListPetViewModel: ObservableObject {
    @Published private(set) var pets = [Pet]()
    @Published private(set) var isLoading = false
    @Published private(set) var isFetching = false
    @Published private(set) var alertMessage = ""
    @Published var isAlertActive = false
    
    private var page = 0
    private var service = APIService()
    private var totalData = 0
    
    @MainActor
    func getPetsData(breedId: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result: (data: [Pet], paginationCount: Int) = try await service.makeRequest(for: PetAPI.pets(breedId: breedId, page: page))
            self.pets = result.data
            self.totalData = result.paginationCount
        } catch {
            isAlertActive = true
            alertMessage = (error as? NetworkError)?.description ?? ""
            print(error)
        }
    }
    
    @MainActor
    func getNextPetsData(breedId: Int) async {
        guard !(pets.count >= totalData) else {
            return
        }
        
        isFetching = true
        defer { isFetching = false }
        
        page += 1
        
        do {
            let result: [Pet] = try await service.makeRequest(for: PetAPI.pets(breedId: breedId, page: page))
            
            // Prevent duplicate data
            for newPet in result {
                if !petExists(withId: newPet.id) {
                    pets.append(newPet)
                }
            }
        } catch {
            isAlertActive = true
            alertMessage = (error as? NetworkError)?.description ?? ""
            print(error)
        }
    }
    
    func hasReachedEnd(of pet: Pet) -> Bool {
        pets.last?.id == pet.id
    }
    
    func refreshedTriggered() {
        pets.removeAll()
        page = 0
        totalData = 0
    }
    
    private func petExists(withId id: String) -> Bool {
        return pets.contains(where: { $0.id == id })
    }
}
