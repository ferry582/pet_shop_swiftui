//
//  SplashScreenView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 16/04/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isFinished = false
    @State private var logoSize = 0.8
    @State private var logoOpacity = 0.5
    
    var body: some View {
        if isFinished {
            LoginView()
        } else {
            ZStack {
                VStack {
                    Image(systemName: "dog.fill")
                        .font(.system(size: 70))
                        .foregroundColor(.accent)
                }
                .scaleEffect(logoSize)
                .opacity(logoOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.4)) {
                        logoSize = 1
                        logoOpacity = 1
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    withAnimation {
                        isFinished = true
                    }
                })
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
