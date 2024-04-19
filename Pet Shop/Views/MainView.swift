//
//  MainView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 18/04/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            NavigationView {
                BreedsView()
                    .navigationTitle("Discover")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarBackButtonHidden()
            }
            .tabItem {
                Label("Pets", systemImage: "dog")
            }
            
            NavigationView {
                FavoriteView()
                    .navigationTitle("Favorites")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarBackButtonHidden()
            }
            .tabItem {
                Label("Favorite", systemImage: "star")
            }   
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainView()
}
