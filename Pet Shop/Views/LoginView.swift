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
        ZStack {
            VStack {
                HStack {
                    Image("dog")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 230)
                        .padding(.leading, -20)
                        .padding(.top, 30)
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                
                VStack {
                    Text(viewModel.title)
                        .foregroundColor(Color.primaryColor)
                        .font(.custom("LeckerliOne-Regular", size: 32))
                        .fontWeight(.semibold)
                        .padding(.bottom, 1)
                        .padding(.top, 40)
                    
                    TextField("Email", text: $emailText)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .focused($focusedField, equals: .email)
                        .padding()
                        .background(Color.textfieldBgColor)
                        .cornerRadius(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(!isValidEmail ? .red : focusedField == .email ? Color.primaryColor : .clear, lineWidth: 2)
                        )
                        .onChange(of: emailText) { newValue in
                            isValidEmail = newValue.isValidEmail
                        }
                        .padding(.top, 34)
                        .padding(.horizontal, 16)
                    
                    SecureField("Password", text: $passwordText)
                        .textContentType(.password)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .focused($focusedField, equals: .password)
                        .padding()
                        .background(Color.textfieldBgColor)
                        .cornerRadius(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(focusedField == .password ? Color.primaryColor : .clear, lineWidth: 2)
                        )
                        .padding(.top, 16)
                        .padding(.horizontal, 16)
                    
                    if !viewModel.isUserHasAccount {
                        SecureField("Comfirm Password", text: $confirmPasswordText)
                            .textContentType(.newPassword)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .focused($focusedField, equals: .confirmPassword)
                            .padding()
                            .background(Color.textfieldBgColor)
                            .cornerRadius(16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(focusedField == .confirmPassword ? Color.primaryColor : .clear, lineWidth: 2)
                            )
                            .padding(.top, 16)
                            .padding(.horizontal, 16)
                    }
                    
                    Button(viewModel.buttonTitle) {
                        viewModel.logInSignUpClicked(email: emailText, password: passwordText, confirmPassword: confirmPasswordText)
                    }
                    .buttonStyle(PrimaryButton())
                    .disabled(!canProceed)
                    .padding(.top, 60)
                    .padding(.bottom, 12)
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Spacer()
                        Text(viewModel.haveAccountMessage)
                            .foregroundColor(Color.textSecondaryColor)
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
                    .padding(.horizontal, 16)
                }
                .background(Color(UIColor.systemBackground))
                .roundedCorner(30, corners: [.topLeft, .topRight])
            }
        }
        .background(Color.mainBgColor)
        .ignoresSafeArea(edges: .bottom)
        .navigationDestination(isPresented: $viewModel.isNavigate) {
            MainView()
        }
    }
}

#Preview {
    LoginView()
}
