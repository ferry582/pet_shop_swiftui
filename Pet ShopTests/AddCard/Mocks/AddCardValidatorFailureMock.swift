//
//  AddCardValidatorFailureMock.swift
//  Pet ShopTests
//
//  Created by Ferry Dwianta P on 24/04/24.
//

import Foundation
@testable import Pet_Shop

class AddCardValidatorFailureMock: CardValidator {
    func validate(_ card: Pet_Shop.CardPayment) throws {
        throw CardValidatorImpl.CardValidatoreError.invalidHolderNameEmpty
    }
}
