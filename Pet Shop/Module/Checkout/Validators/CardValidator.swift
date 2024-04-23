//
//  CardValidator.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 23/04/24.
//

import Foundation

struct CardValidator {
    func validate(_ card: CardPayment) throws {
        if card.holderName.isEmpty {
            throw CardValidatoreError.invalidHolderNameEmpty
        }
        
        if card.number.isEmpty {
            throw CardValidatoreError.invalidCardNumberEmpty
        }
        
        if card.expMonth.isEmpty {
            throw CardValidatoreError.invalidExpMonthEmpty
        }
        
        if card.expYear.isEmpty {
            throw CardValidatoreError.invalidExpYearEmpty
        }
        
        if card.ccv.isEmpty {
            throw CardValidatoreError.invalidCCVEmpty
        }
        
        if card.number.count != 19 {
            throw CardValidatoreError.invalidCardNumberDigit
        }
        
        if card.expMonth.count != 2 {
            throw CardValidatoreError.invalidExpMonthDigit
        }
        
        if card.expYear.count != 2 {
            throw CardValidatoreError.invalidExpYearDigit
        }
        
        if card.ccv.count != 3 {
            throw CardValidatoreError.invalidCCVDigit
        }
    }
}

extension CardValidator {
    enum CardValidatoreError: LocalizedError {
        case invalidHolderNameEmpty
        case invalidCardNumberEmpty
        case invalidExpMonthEmpty
        case invalidExpYearEmpty
        case invalidCCVEmpty
        case invalidCardNumberDigit
        case invalidExpMonthDigit
        case invalidExpYearDigit
        case invalidCCVDigit
    }
}

extension CardValidator.CardValidatoreError {
    var errorDescription: String? {
        switch self {
        case .invalidHolderNameEmpty:
            "Holder name can't be empty"
        case .invalidCardNumberEmpty:
            "Card Number can't be empty"
        case .invalidExpMonthEmpty:
            "Expired month can't be empty"
        case .invalidExpYearEmpty:
            "Expired year can't be empty"
        case .invalidCCVEmpty:
            "CCV can't be empty"
        case .invalidCardNumberDigit:
            "Card Number must be 16 digits"
        case .invalidExpMonthDigit:
            "Expire Month must be 2 digits"
        case .invalidExpYearDigit:
            "Expire Year must be 2 digits"
        case .invalidCCVDigit:
            "CCV must be 3 digits"
        }
    }
}
