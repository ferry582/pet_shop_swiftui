//
//  ListPetView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 17/04/24.
//

import SwiftUI

struct ListPetView: View {
    @StateObject private var viewModel = ListPetViewModel()
    @State private var hasAppeared = false
    
    let breed: Breed
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Choose the dog, that you like!")
                            .foregroundColor(Color.textSecondaryColor)
                            .font(.system(size: 18))
                        Spacer()
                    }
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.pets, id: \.id) { pet in
                            NavigationLink {
                                PetDetailView(pet: pet)
                            } label: {
                                PetCellView(pet: pet)
                                    .task {
                                        if viewModel.hasReachedEnd(of: pet) && !viewModel.isFetching{
                                            await viewModel.getNextPetsData(breedId: breed.id)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .refreshable {
                viewModel.refreshedTriggered()
                Task {
                    await viewModel.getPetsData(breedId: breed.id)
                }
            }
            .overlay(alignment: .bottom) {
                if viewModel.isFetching {
                    ProgressView()
                        .scaleEffect(1.4, anchor: .center)
                        .padding(.bottom, 34)
                }
            }
            .alert(viewModel.alertMessage, isPresented: $viewModel.isAlertActive) {
                Button("OK", role: .cancel) { }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
            
            if viewModel.pets.isEmpty && !viewModel.isLoading {
                EmptyStateView()
            }
        }
        .navigationTitle(breed.name)
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal, 16)
        .ignoresSafeArea(edges: .bottom)
        .task {
            if !hasAppeared {
                await viewModel.getPetsData(breedId: breed.id)
                hasAppeared = true
            }
        }
    }
}

#Preview {
    ListPetView(breed: Breed(weight: Size(imperial: "", metric: ""), height: Size(imperial: "", metric: ""), id: 1, name: "", lifeSpan: "", breedGroup: "", bredFor: "", origin: "", temperament: "", referenceImageID: ""))
}


struct PetCellView: View {
    var pet: Pet
    
    var body: some View {
        ZStack {
            HStack {
                AsyncImageView(url: pet.url)
                    .frame(width: 100, height: 100)
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10.0)
        .padding(.vertical, 6)
    }
}

