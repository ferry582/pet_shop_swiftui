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
    func addToFavorite(petId: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result: FavoriteResponse = try await service.makeRequest(for: PetAPI.addFavorite(petId: petId, userId: currentEmail))
            isAlertActive = true
            
            self.alertMessage = if result.message == "SUCCESS" {
                "Added to your favorite"
            } else {
                "Can't add to your favorite"
            }
        } catch {
            isAlertActive = true
            alertMessage = (error as? NetworkError)?.description ?? ""
            print(error)
        }
    }
}
