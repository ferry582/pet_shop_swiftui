//
//  LoginFormValidator.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 25/04/24.
//

import Foundation

protocol AuthValidator {
    func validateLogIn(email: String, password: String) throws
    func validateSignUp(email: String, password: String, confirmPassword: String) throws
}

struct AuthValidatorImpl: AuthValidator {
    func validateLogIn(email: String, password: String) throws {
        if email.isEmpty {
            throw AuthValidatoreError.invalidEmailEmpty
        }
        
        if password.isEmpty {
            throw AuthValidatoreError.invalidPasswordEmpty
        }
        
        if !email.isValidEmail {
            throw AuthValidatoreError.invalidEmail
        }
    }
    
    func validateSignUp(email: String, password: String, confirmPassword: String) throws {
        if email.isEmpty {
            throw AuthValidatoreError.invalidEmailEmpty
        }
        
        if password.isEmpty {
            throw AuthValidatoreError.invalidPasswordEmpty
        }
        
        if confirmPassword.isEmpty {
            throw AuthValidatoreError.invalidConfirmPasswordEmpty
        }
        
        if !email.isValidEmail {
            throw AuthValidatoreError.invalidEmail
        }
    }
}

extension AuthValidatorImpl {
    enum AuthValidatoreError: LocalizedError {
        case invalidEmailEmpty
        case invalidPasswordEmpty
        case invalidConfirmPasswordEmpty
        case invalidEmail
        
        var errorDescription: String? {
            switch self {
            case .invalidEmailEmpty:
                "Email can't be empty"
            case .invalidPasswordEmpty:
                "Password can't be empty"
            case .invalidConfirmPasswordEmpty:
                "Confirm Password can't be empty"
            case .invalidEmail:
                "Invalid Email! Enter Correct Email"
            }
        }
    }
}
