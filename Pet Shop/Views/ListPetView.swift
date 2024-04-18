//
//  ListPetView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 17/04/24.
//

import SwiftUI

struct ListPetView: View {
    @StateObject private var viewModel = ListPetViewModel()
    
    let breed: Breed
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoadingView()
            } else {
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
                                    PetDetailView()
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
            }
        }
        .navigationTitle(breed.name)
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal, 16)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            Task {
                await viewModel.getPetsData(breedId: breed.id)
            }
        }
    }
}

#Preview {
    ListPetView(breed: Breed(weight: Size(imperial: "", metric: ""), height: Size(imperial: "", metric: ""), id: 1, name: "", lifeSpan: "", breedGroup: "", bredFor: "", temperament: "", referenceImageID: ""))
}


struct PetCellView: View {
    var pet: Pet
    
    var body: some View {
        ZStack {
            HStack {
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
                .frame(width: 100, height: 100)
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10.0)
        .padding(.vertical, 6)
    }
}

