//
//  CheckoutViewModel.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 20/04/24.
//

import Foundation

class CheckoutDetailViewModel: ObservableObject {
    @Published var totalPrice = 0
    @Published var totalTax: Double = 0
    @Published var totalFee: Double = 0
    
    func calculatePayment(cart: [Favorite]) {
        let total = cart.reduce(0) { $0 + ($1.pet.price ?? 0) }
        let tax = Double(total)*0.10
        let fee = Double(total)*0.02
        totalPrice = total
        totalTax = tax
        totalFee = fee
    }
}
