//
//  PetDetailView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 18/04/24.
//

import SwiftUI

struct PetDetailView: View {
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "star.fill")
                        .font(.title)
                }
                
                Button("Add to Cart") {
                    
                }
                .buttonStyle(PrimaryButton())
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    PetDetailView()
}
