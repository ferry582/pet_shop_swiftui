//
//  PetDetailViewModel.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 18/04/24.
//

import SwiftUI

class PetDetailViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var alertMessage = ""
    @Published var isAlertActive = false
    @AppStorage("current_email") private var currentEmail = ""
    
    private var service = APIService()
    
    @MainActor
    func addToFavorite(pet: Pet) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result: FavoriteResponse = try await service.makeRequest(for: PetAPI.addFavorite(petId: pet.id, userId: currentEmail))
            isAlertActive = true
            if result.message == "SUCCESS" {
                self.alertMessage = "Added to your favorite"
                addFavoriteToDefaults(id: result.id ?? 0, price: pet.price ?? 0)
            } else {
                self.alertMessage = "Can't add to your favorite"
            }
        } catch {
            isAlertActive = true
            alertMessage = (error as? NetworkError)?.description ?? "Network Error! Something went wrong"
            print(error)
        }
    }
    
    private func addFavoriteToDefaults(id: Int, price: Int) {
        var favorites = UserDefaults.standard.dictionary(forKey: "favorite_pet") ?? [:]
        let favorite = [String(id):price]
        favorites.merge(favorite, uniquingKeysWith: { $1 })
        UserDefaults.standard.set(favorites, forKey: "favorite_pet")
    }
}
