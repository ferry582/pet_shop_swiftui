//
//  LoginViewModel.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 16/04/24.
//

import SwiftUI
import Security

class LoginViewModel: ObservableObject {
    
    @Published var buttonTitle = "Log In"
    @Published var haveAccountMessage = "Don't have an account?"
    @Published var haveAccountButton = "Sign Up"
    @Published var isNavigate = false
    @Published var alertMessage = ""
    @Published var isAlertActive = false
    @Published var isUserHasAccount = true
    
    func haveAccountClicked() {
        isUserHasAccount.toggle()
        
        if isUserHasAccount {
            buttonTitle = "Log In"
            haveAccountMessage = "Don't have an account?"
            haveAccountButton = "Sign Up"
        } else {
            buttonTitle = "Sign Up"
            haveAccountMessage = "Already have an account?"
            haveAccountButton = "Log In"
        }
        
    }
    
    func logInSignUpClicked(email: String, password: String, confirmPassword: String) {
        if !isUserHasAccount {
            if let _ = KeychainHelper.standard.read(service: "user-auth", account: email) {
                isAlertActive = true
                alertMessage = "Your email already exist! Please Log In with your registered email"
            } else {
                if password == confirmPassword {
                    KeychainHelper.standard.save(Data(password.utf8), service: "user-auth", account: email)
                    isNavigate = true
                } else {
                    isAlertActive = true
                    alertMessage = "Password doesn't match!"
                }
            }
        } else {
            if let data = KeychainHelper.standard.read(service: "user-auth", account: email) {
                let keyChainPass = String(data: data, encoding: .utf8)
                
                if password == keyChainPass {
                    isNavigate = true
                } else {
                    isAlertActive = true
                    alertMessage = "Wrong Password!"
                }
            } else {
                isAlertActive = true
                alertMessage = "Your email is not registered! Please register your email first"
            }
        }
    }
    
}
