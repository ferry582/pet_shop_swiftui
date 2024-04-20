//
//  SecondaryButton.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 20/04/24.
//

import SwiftUI

struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: 54, alignment: .center)
            .font(.system(size: 17, weight: .bold))
            .background(Color.clear)
            .foregroundColor(Color.primaryColor)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primaryColor, lineWidth: 1)
            )
    }
}
