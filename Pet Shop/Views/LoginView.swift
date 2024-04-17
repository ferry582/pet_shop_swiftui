//
//  LoginView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 16/04/24.
//

import SwiftUI

enum FocusedField {
    case email
    case password
    case confirmPassword
}

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var confirmPasswordText = ""
    @State private var isValidEmail = true
    @FocusState private var focusedField: FocusedField?
    
    private var canProceed: Bool {
        isValidEmail &&
        !passwordText.isEmpty &&
        !emailText.isEmpty &&
        (!confirmPasswordText.isEmpty || viewModel.isUserHasAccount)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Hey") +
                Text("\nPet Lovers!")
                    .foregroundColor(.accent)
                
                Spacer()
            }
            .font(.system(.largeTitle))
            .fontWeight(.semibold)
            .padding(.bottom, 1)
            .padding(.top, 44)
            
            HStack {
                Text("Welcome! Find your perfect companion at our pet shop")
                    .foregroundColor(.textSecondary)
                    .font(.system(size: 18))
                Spacer()
            }
            .padding(.top, 4)
            
            TextField("Email", text: $emailText)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .email)
                .padding()
                .background(.textFieldBg)
                .cornerRadius(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(!isValidEmail ? .red : focusedField == .email ? .accent : .clear, lineWidth: 2)
                )
                .onChange(of: emailText) { newValue in
                    isValidEmail = newValue.isValidEmail
                }
                .padding(.top, 34)
            
            SecureField("Password", text: $passwordText)
                .textContentType(.password)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .password)
                .padding()
                .background(.textFieldBg)
                .cornerRadius(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(focusedField == .password ? .accent : .clear, lineWidth: 2)
                )
                .padding(.top, 16)
            
            if !viewModel.isUserHasAccount {
                SecureField("Comfirm Password", text: $confirmPasswordText)
                    .textContentType(.newPassword)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .confirmPassword)
                    .padding()
                    .background(.textFieldBg)
                    .cornerRadius(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(focusedField == .confirmPassword ? .accent : .clear, lineWidth: 2)
                    )
                    .padding(.top, 16)
            }
            
            Spacer()
            
            Button(viewModel.buttonTitle) {
                viewModel.logInSignUpClicked(email: emailText, password: passwordText, confirmPassword: confirmPasswordText)
            }
            .buttonStyle(PrimaryButton())
            .disabled(!canProceed)
            .padding(.top, 24)
            .padding(.bottom, 12)
            
            HStack {
                Spacer()
                Text(viewModel.haveAccountMessage)
                    .foregroundColor(.textSecondary)
                    .font(.body)
                
                Button {
                    viewModel.haveAccountClicked()
                } label: {
                    Text(viewModel.haveAccountButton)
                        .font(.body)
                        .fontWeight(.semibold)
                }
                .alert(viewModel.alertMessage, isPresented: $viewModel.isAlertActive) {
                    Button("OK", role: .cancel) { }
                }
                Spacer()
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 16)
        .ignoresSafeArea(edges: .bottom)
        .navigationDestination(isPresented: $viewModel.isNavigate) {
            ContentView()
                .navigationTitle("Pet Shop")
        }
    }
}

#Preview {
    LoginView()
}
