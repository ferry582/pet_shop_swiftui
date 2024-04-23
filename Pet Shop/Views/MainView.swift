//
//  MainView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 18/04/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
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
                FavoriteView(selectedTab: $selectedTab)
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
