//
//  LoginFormValidator.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 25/04/24.
//

import Foundation

protocol LoginValidator {
    func validateLogIn(email: String, password: String) throws
    func validateSignUp(email: String, password: String, confirmPassword: String) throws
}

struct LoginValidatorImpl: LoginValidator {
    func validateLogIn(email: String, password: String) throws {
        if email.isEmpty {
            throw LoginValidatoreError.invalidEmailEmpty
        }
        
        if password.isEmpty {
            throw LoginValidatoreError.invalidPasswordEmpty
        }
        
        if !email.isValidEmail {
            throw LoginValidatoreError.invalidEmail
        }
    }
    
    func validateSignUp(email: String, password: String, confirmPassword: String) throws {
        if email.isEmpty {
            throw LoginValidatoreError.invalidEmailEmpty
        }
        
        if password.isEmpty {
            throw LoginValidatoreError.invalidPasswordEmpty
        }
        
        if confirmPassword.isEmpty {
            throw LoginValidatoreError.invalidConfirmPasswordEmpty
        }
        
        if !email.isValidEmail {
            throw LoginValidatoreError.invalidEmail
        }
    }
}

extension LoginValidatorImpl {
    enum LoginValidatoreError: LocalizedError {
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
