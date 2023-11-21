//
//  UpdateOrderBottomSheet.swift
//  pecunia
//
//  Created by gabriel on 08/11/23.
//

import SwiftUI

struct UpdateOrderBottomSheet: View {
    @FocusState var focused: Bool?
    @State private var orderName: String = ""
    @Binding var isShowing: Bool
    @State private var isLoading = false
    @State private var showingAlert = false
    @ObservedObject var viewModel = UpdateOrderBottomSheetViewModel()
    @State private var redirectToProducts = false
    
    @State private var orderError: String = ""
    
    var didSelectOrderName: (_ orderName: String) -> Void
    
    var body: some View {
        NavigationView {
    
        VStack {
            
            HStack {
                Button(action: {
                    isShowing = false
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: 50, maxHeight: 50)
                        Text("X")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, 40)
                .padding(.top, 40)
                
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text("Nova Compra")
                .font(.system(size: 18))
                .padding(.top, 40)
                .padding(.horizontal, 20)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Qual será o nome da sua nova compra?")
                .font(.system(size: 28).bold())
                .padding(.horizontal, 20)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Nome da Compra", text: $orderName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
                .padding(.top, 40)
                .focused($focused, equals: true)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.focused = true
                    }
                }
            
            
            
            Spacer()
                LoadingButton(isLoading: $isLoading, action: {
                    isLoading = true
                    
                    viewModel.validateOrderName(orderName: orderName) { (result: Result<ValidateOrder, Error>) in
                        
                        switch result {
                        case let .success(response):
                            if response.status >= 200 && response.status <= 210 {
                                if response.isAvailable {
                                    didSelectOrderName(orderName)
                                } else {
                                    showingAlert = true
                                    orderError = "Você já possui uma compra com este nome"
                                    isLoading = false
                                }
                            } else {
                                showingAlert = true
                                orderError = "Ocorreu um erro"
                                isLoading = false
                            }
                        case .failure(_):
                            showingAlert = true
                            orderError = "Ocorreu um erro"
                            isLoading = false
                            break;
                        }
                    }
                    
                }) {
                    
                    Text("Continuar")
                        .foregroundColor(.white)
                }
                .padding()
                
        }
        .padding()
        .background(Color.white)
        .alert(isPresented: $showingAlert, content: {
            Alert(
                title: Text(""),
                message: Text(orderError),
                dismissButton: .default(Text("Ok"))
            )
        })
    }
    }
}

