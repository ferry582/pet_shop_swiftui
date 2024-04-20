//
//  CheckoutCompleteView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 20/04/24.
//

import SwiftUI

struct CheckoutCompleteView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(Color.green)
            
            Text("Congratulations")
                .font(.title)
            
            Text("Your order has been\nsuccessfully placed.")
                .multilineTextAlignment(.center)
            
            Text("Order ID is **334390241**")
        }
    }
}

#Preview {
    CheckoutCompleteView()
}
