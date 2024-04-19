//
//  FavoriteViewModel.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 19/04/24.
//

import SwiftUI

class FavoriteViewModel: ObservableObject {
    @Published private(set) var favorites = [Favorite]()
    @Published private(set) var isLoading = false
    @Published private(set) var alertMessage = ""
    @Published var isAlertActive = false
    
    @AppStorage("current_email") private var currentEmail = ""
    private var service = APIService()
    
    @MainActor
    func getFavoritesData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result: [Favorite] = try await service.makeRequest(for: PetAPI.favorites(userId: currentEmail))
            favorites = result
        } catch {
            isAlertActive = true
            alertMessage = (error as? NetworkError)?.description ?? ""
            print(error)
        }
    }
    
    @MainActor
    func deleteFavorite(id: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result: FavoriteResponse = try await service.makeRequest(for: PetAPI.deleteFavorite(id: id))
            
            isAlertActive = true
            if result.message == "SUCCESS" {
                if let index = favorites.firstIndex(where: {$0.id == id}) {
                    favorites.remove(at: index)
                }
                self.alertMessage = "Removed from favorite"
            } else {
                self.alertMessage = "Can't remove your favorite"
            }
        } catch {
            isAlertActive = true
            alertMessage = (error as? NetworkError)?.description ?? ""
            print(error)
        }
    }
    
    func refreshedTriggered() {
        favorites.removeAll()
    }
}
