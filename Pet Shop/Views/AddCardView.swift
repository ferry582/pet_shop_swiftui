//
//  AddCardView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 20/04/24.
//

import SwiftUI

enum CardFocusedField {
    case name
    case number
    case expiryDate
    case ccv
}

struct AddCardView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var cardInfo: CardPayment
    @FocusState private var focusedField: CardFocusedField?
    @State private var tempCard: CardPayment = CardPayment()
    @State private var isValidNumber = true
    @State private var isValidExpiryDate = true
    @State private var isValidCCV = true
    
    private var canProceed: Bool {
        !tempCard.holderName.isEmpty &&
        !tempCard.number.isEmpty &&
        !tempCard.expMonth.isEmpty &&
        !tempCard.expYear.isEmpty &&
        !tempCard.ccv.isEmpty &&
        isValidNumber &&
        isValidExpiryDate &&
        isValidCCV
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Card Holder's Name", text: $tempCard.holderName)
                    .textContentType(.name)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .name)
                    .padding()
                    .background(Color.textfieldBgColor)
                    .cornerRadius(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(focusedField == .name ? Color.primaryColor : .clear, lineWidth: 2)
                    )
                    .padding(.top, 16)
                
                TextField("Card Number", text: $tempCard.number)
                    .keyboardType(.numberPad)
                    .textContentType(.creditCardNumber)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .number)
                    .padding()
                    .background(Color.textfieldBgColor)
                    .cornerRadius(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(!isValidNumber ? .red : focusedField == .number ? Color.primaryColor : .clear, lineWidth: 2)
                    )
                    .padding(.top, 16)
                    .onChange(of: tempCard.number) { newValue in
                        let cleanedText = newValue.filter { $0.isNumber }
                        if cleanedText.count > 16 {
                            tempCard.number = String(cleanedText.prefix(16))
                            return
                        }
                        let formattedText = cleanedText.separated(by: " ", stride: 4)
                        tempCard.number = formattedText
                        isValidNumber = cleanedText.count == 16
                    }
                
                HStack {
                    HStack {
                        Spacer()
                        TextField("08", text: $tempCard.expMonth)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .textContentType(.dateTime)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .focused($focusedField, equals: .expiryDate)
                            .padding(.vertical)
                            .padding(.leading)
                            .onChange(of: tempCard.expMonth) { newValue in
                                let cleanedText = newValue.filter { $0.isNumber }
                                if cleanedText.count > 2 {
                                    tempCard.expMonth = String(cleanedText.prefix(2))
                                    return
                                }
                                tempCard.expMonth = cleanedText
                                isValidExpiryDate = cleanedText.count == 2
                            }
                        
                        Text("/")
                            .font(.title3)
                        
                        TextField("24", text: $tempCard.expYear)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .textContentType(.dateTime)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .focused($focusedField, equals: .expiryDate)
                            .padding(.vertical)
                            .padding(.trailing)
                            .onChange(of: tempCard.expYear) { newValue in
                                let cleanedText = newValue.filter { $0.isNumber }
                                if cleanedText.count > 2 {
                                    tempCard.expYear = String(cleanedText.prefix(2))
                                    return
                                }
                                tempCard.expYear = cleanedText
                                isValidExpiryDate = cleanedText.count == 2
                            }
                        Spacer()
                    }
                    .background(Color.textfieldBgColor)
                    .cornerRadius(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(!isValidExpiryDate ? .red : focusedField == .expiryDate ? Color.primaryColor : .clear, lineWidth: 2)
                    )
                    .padding(.top, 16)
                    .padding(.trailing, 16)
                    
                    TextField("CCV", text: $tempCard.ccv)
                        .keyboardType(.numberPad)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .focused($focusedField, equals: .ccv)
                        .padding()
                        .background(Color.textfieldBgColor)
                        .cornerRadius(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(!isValidCCV ? .red : focusedField == .ccv ? Color.primaryColor : .clear, lineWidth: 2)
                        )
                        .padding(.top, 16)
                        .onChange(of: tempCard.ccv) { newValue in
                            let cleanedText = newValue.filter { $0.isNumber }
                            if cleanedText.count > 3 {
                                tempCard.ccv = String(cleanedText.prefix(3))
                                return
                            }
                            tempCard.ccv = cleanedText
                            isValidCCV = cleanedText.count == 3
                        }
                }
                
                Spacer()
            }
            .navigationTitle("Card Info")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, 16)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        cardInfo = tempCard
                        dismiss()
                    }
                    .disabled(!canProceed)
                }
            }
            .onAppear {
                if !cardInfo.holderName.isEmpty {
                    tempCard = cardInfo
                }
            }
        }
    }
}
