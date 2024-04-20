//
//  CheckoutView.swift
//  Pet Shop
//
//  Created by Ferry Dwianta P on 20/04/24.
//

import SwiftUI

protocol CheckoutDetailViewDelegate {
    func didCheckoutComplete(for cart: [Favorite])
}

struct CheckoutDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CheckoutDetailViewModel()
    @State private var isPresentCheckoutCompleteView = false
    @State private var isPresentAddCardView = false
    @State private var cardInfo: CardPayment = CardPayment()
    
    var delegate: CheckoutDetailViewDelegate?
    var cart: [Favorite]
    
    var body: some View {
        ZStack {
            GeometryReader { reader in
                List {
                    Section("Items") {
                        LazyVStack {
                            ForEach(cart, id: \.id) { item in
                                CartItemCellView(item: item)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.hidden)
                    
                    Section("Payment Summary") {
                        VStack(spacing: 12) {
                            HStack {
                                Text("Total price (\(cart.count))")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.textSecondaryColor)
                                Spacer()
                                Text("$\(viewModel.totalPrice)")
                                    .font(.system(size: 14))
                            }
                            .padding(.top, 12)
                            .padding(.horizontal, 12)
                            
                            HStack {
                                Text("Total tax (10%)")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.textSecondaryColor)
                                Spacer()
                                Text("$\(viewModel.totalTax, specifier: "%.2f")")
                                    .font(.system(size: 14))
                            }
                            .padding(.horizontal, 12)
                            
                            HStack {
                                Text("Platform fee (0.2%)")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.textSecondaryColor)
                                Spacer()
                                Text("$\(viewModel.totalFee, specifier: "%.2f")")
                                    .font(.system(size: 14))
                            }
                            .padding(.horizontal, 12)
                            
                            HStack {
                                Text("Total payment")
                                    .font(.system(size: 14))
                                    .bold()
                                Spacer()
                                Text("$\(Double(viewModel.totalPrice) + viewModel.totalTax + viewModel.totalTax, specifier: "%.2f")")
                                    .font(.system(size: 14))
                                    .bold()
                                    .foregroundColor(Color.primaryColor)
                            }
                            .bold()
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                        }
                        .background(Color.cardBgColor)
                        .cornerRadius(16)
                    }
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.hidden)
                    
                    Section("Payment Details") {
                        if cardInfo.number.isEmpty {
                            Button {
                                isPresentAddCardView.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: "plus.app")
                                    Text("Add Card")
                                }
                            }
                            .buttonStyle(SecondaryButton())
                            .frame(width: reader.size.width - 32, height: 54)
                            .padding(.bottom, 78)
                        } else {
                            VStack {
                                HStack {
                                    Text("Payment Card")
                                        .font(.system(size: 16))
                                    Spacer()
                                    Button {
                                        isPresentAddCardView.toggle()
                                    } label: {
                                        Text("Edit")
                                            .font(.system(size: 16))
                                            .bold()
                                    }
                                }
                                .padding(12)
                                
                                HStack {
                                    Text("**** **** \(String(cardInfo.number.suffix(4)))")
                                        .font(.system(size: 14))
                                    Spacer()
                                    Text("\(cardInfo.expMonth)/\(cardInfo.expYear)")
                                        .font(.system(size: 14))
                                }
                                .padding(.horizontal, 12)
                                .padding(.bottom, 12)
                            }
                            .background(Color.cardBg)
                            .cornerRadius(16)
                            .padding(.bottom, 78)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.hidden)
                    
                }
                .listStyle(.grouped)
                .scrollIndicators(.hidden)
                
                VStack {
                    Spacer()
                    
                    Button("Pay") {
                        isPresentCheckoutCompleteView.toggle()
                        delegate?.didCheckoutComplete(for: cart)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            dismiss()
                        })
                    }
                    .buttonStyle(PrimaryButton())
                    .shadow(radius: 10, y: 28)
                    .padding(.bottom, 12)
                    .padding(.horizontal, 16)
                }
            }
        }
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.calculatePayment(cart: cart)
        }
        .fullScreenCover(isPresented: $isPresentCheckoutCompleteView, content: CheckoutCompleteView.init)
        .sheet(isPresented: $isPresentAddCardView) {
            AddCardView(cardInfo: $cardInfo)
        }
    }
}

#Preview {
    CheckoutDetailView(cart: [])
}

struct CartItemCellView: View {
    let item: Favorite
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.pet.url)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image(systemName: "questionmark.diamond")
                        .imageScale(.large)
                } else {
                    ProgressView()
                }
            }
            .frame(width: 45, height: 45)
            
            Text("$\(item.pet.price ?? 0)")
            
            Spacer()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        .background(Color.cardBg)
        .cornerRadius(16)
    }
}

