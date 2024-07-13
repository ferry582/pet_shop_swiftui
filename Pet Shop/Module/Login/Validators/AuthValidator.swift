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
            throw AuthValidatorError.invalidEmailEmpty
        }
        
        if password.isEmpty {
            throw AuthValidatorError.invalidPasswordEmpty
        }
        
        if !email.isValidEmail {
            throw AuthValidatorError.invalidEmail
        }
    }
    
    func validateSignUp(email: String, password: String, confirmPassword: String) throws {
        if email.isEmpty {
            throw AuthValidatorError.invalidEmailEmpty
        }
        
        if password.isEmpty {
            throw AuthValidatorError.invalidPasswordEmpty
        }
        
        if confirmPassword.isEmpty {
            throw AuthValidatorError.invalidConfirmPasswordEmpty
        }
        
        if !email.isValidEmail {
            throw AuthValidatorError.invalidEmail
        }
    }
}

extension AuthValidatorImpl {
    enum AuthValidatorError: LocalizedError {
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
