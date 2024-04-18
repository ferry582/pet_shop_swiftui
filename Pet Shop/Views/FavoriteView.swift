//
//  FavoriteView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 18/04/24.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    @State private var hasAppeared = false
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ZStack {
            if viewModel.favorites.isEmpty && !viewModel.isLoading {
                Text("Add your favorite pets here!")
            } else {
                ScrollView {
                    VStack {
                        HStack {
                            Text("Favorites")
                                .font(.largeTitle)
                                .bold()
                                .padding(.top, 42)
                                .padding(.bottom, 2)
                            Spacer()
                        }
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.favorites, id: \.id) { favorite in
                                FavoriteCellView(favorite: favorite)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .refreshable {
                    viewModel.refreshedTriggered()
                    Task {
                        await viewModel.getFavoritesData()
                    }
                }
                .alert(viewModel.alertMessage, isPresented: $viewModel.isAlertActive) {
                    Button("OK", role: .cancel) { }
                }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .padding(.horizontal, 16)
        .task {
            if !hasAppeared {
                await viewModel.getFavoritesData()
                hasAppeared = true
            }
        }
        
    }
}

#Preview {
    FavoriteView()
}

struct FavoriteCellView: View {
    var favorite: Favorite
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: favorite.image.url)) { phase in
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
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "trash.fill")
                            .frame(width: 30, height: 30)
                            .tint(.red)
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10.0)
        .padding(.vertical, 6)
    }
}
