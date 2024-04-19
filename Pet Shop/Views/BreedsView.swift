//
//  ContentView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 16/04/24.
//

import SwiftUI

struct BreedsView: View {
    @StateObject private var viewModel = BreedsViewModel()
    @State private var hasAppeared = false
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    HStack {
                        Text("Choose the dog breed, that you prefer!")
                            .foregroundColor(Color.textSecondaryColor)
                            .font(.system(size: 18))
                        Spacer()
                    }
                    
                    ForEach(viewModel.breeds, id: \.id) { breed in
                        NavigationLink {
                            ListPetView(breed: breed)
                        } label: {
                            BreedCellView(breed: breed, viewModel: viewModel)
                                .task {
                                    if viewModel.hasReachedEnd(of: breed) && !viewModel.isFetching{
                                        await viewModel.getNextBreedsData()
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
                    await viewModel.getBreedsData()
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
        }
        .padding(.horizontal, 16)
        .task {
            if !hasAppeared {
                await viewModel.getBreedsData()
                hasAppeared = true
            }
        }
    }
}

#Preview {
    BreedsView()
}

struct BreedCellView: View {
    var breed: Breed
    var viewModel: BreedsViewModel
    
    @State private var imageUrl = ""
    
    var body: some View {
        ZStack {
            HStack {
                AsyncImage(url: URL(string: imageUrl)) { phase in
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
                
                Text("\(breed.name)")
                    .font(.title3)
            }
            .onAppear {
                Task {
                    imageUrl = await viewModel.getBreedImageData(petId: breed.referenceImageID)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10.0)
        .padding(.vertical, 6)
    }
}
