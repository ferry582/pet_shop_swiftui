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
                Image("dog.fill")
                    .renderingMode(.template)
                    .foregroundStyle(selectedTab == 0 ? Color.appPrimaryColor : Color.gray)
                Text("Pets")
            }
            .tag(0)
            
            NavigationView {
                FavoriteView(selectedTab: $selectedTab)
                    .navigationTitle("Favorites")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarBackButtonHidden()
            }
            .tabItem {
                Label("Favorite", systemImage: "star")
            }   
            .tag(1)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainView()
}
