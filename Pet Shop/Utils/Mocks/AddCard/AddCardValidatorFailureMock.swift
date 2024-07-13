//
//  AddCardValidatorFailureMock.swift
//  Pet ShopTests
//
//  Created by Ferry Dwianta P on 24/04/24.
//

#if DEBUG
import Foundation

class AddCardValidatorFailureMock: CardValidator {
    func validate(_ card: Pet_Shop.CardPayment) throws {
        throw CardValidatorImpl.CardValidatoreError.invalidHolderNameEmpty
    }
}
#endif
