//
//  PetDetailView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 18/04/24.
//

import SwiftUI

struct PetDetailView: View {
    @StateObject private var viewModel = PetDetailViewModel()
    let pet: Pet
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: URL(string: pet.url)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else if phase.error != nil {
                        Image(systemName: "questionmark.diamond")
                            .imageScale(.large)
                    } else {
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, -16)
                
                Text("Breed: \(pet.breeds?[0].name ?? "")")
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.addToFavorite(petId: pet.id)
                    }
                } label: {
                    HStack {
                        Image(systemName: "star.fill")
                        Text("Add to Favorite")
                    }
                }
                .buttonStyle(PrimaryButton())
            }
            .alert(viewModel.alertMessage, isPresented: $viewModel.isAlertActive) {
                Button("OK", role: .cancel) { }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    PetDetailView(pet: Pet(id: "BJa4kxc4X", url: "https://cdn2.thedogapi.com/images/BJa4kxc4X_1280.jpg", breeds: [Breed(weight: Size(imperial: "", metric: ""), height: Size(imperial: "", metric: ""), id: 1, name: "American bull", lifeSpan: "", breedGroup: "", bredFor: "", temperament: "", referenceImageID: "")], width: 1600, height: 1199))
}
