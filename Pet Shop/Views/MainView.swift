//
//  MainView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 18/04/24.
//

import SwiftUI

struct MainView: View {
    @State var selection = 1
    
    var body: some View {
        TabView {
            BreedsView()
                .tabItem {
                    Label("Pets", systemImage: "dog")
                }
            
            FavoriteView()
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
