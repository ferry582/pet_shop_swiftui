//
//  ContentView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 16/04/24.
//

import SwiftUI

struct BreedsView: View {
    @StateObject private var viewModel = BreedsViewModel()
    
    var body: some View {
        ZStack {
            Text(!viewModel.breeds.isEmpty ? viewModel.breeds[0].name : "")
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getBreedsData()
        }
    }
}

#Preview {
    BreedsView()
}
