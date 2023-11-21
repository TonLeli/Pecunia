//
//  UpdateOrdersSelectProductsView.swift
//  pecunia
//
//  Created by Wellington on 08/11/23.
//

import SwiftUI

struct UpdateOrdersSelectProductsView: View {
    @ObservedObject var viewModel = UpdateOrdersSelectProductsViewModel()
    var orderName: String
    @State private var productSearch: String = ""
    @State private var timer: Timer?
    @State private var isLoading = false
    @State private var productSelections: [ProductSelection] = []
    @Binding var isShowingOrderFlow: Bool
    @State private var showingAlert = false
    @State private var alertText: String = ""
    @Environment(\.presentationMode) var presentationMode
    

    var body: some View {
        ZStack {
            VStack(spacing: .zero) { Color("orangeColor"); Color.black }
                .ignoresSafeArea()

            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 120)
                    .foregroundColor(.white)
                    .overlay(
                        ZStack {
                            HStack {
                                VStack {
                                    Text("Buscar Produto")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 20)
                                        .font(.system(size: 20).bold())
                                    
                                    TextField(
                                        "Digite o nome do produto",
                                        text: $productSearch
                                    )
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.horizontal, 20)
                                    .onChange(of: productSearch, perform: { value in
                                        timer?.invalidate()
                                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                                            viewModel.searchProduct(with: productSearch)
                                        }
                                    })
                                }
                                Spacer()
                                
                                if viewModel.shouldShowLoading  {
                                    ProgressView()
                                        .padding(.trailing, 30)
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color.orange))
                                } else {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.black)
                                        .padding(.trailing, 20)
                                        .font(.system(size: 25))
                                }
                                
                            }
                        }
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 30)

                
                if let itemList = viewModel.productsResponse {
                    UpdateOrderSelectProductsItemView(
                        productSelections: $productSelections,
                        products: itemList
              
                    )
                }
                 
                LoadingButton(isLoading: $isLoading, action: {
                    isLoading = true
                    viewModel.saveOrder(orderName: orderName, selectedProducts: productSelections) { (result: Result<SaveOrderResponse, Error>) in
                        
                        switch result {
                        case let .success(response) :
                            
                            if response.status >= 200 && response.status <= 210 {
                                showingAlert = true
                                alertText = "Sua compra foi salva com sucesso"
                                
                    
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isLoading = false
                                    isShowingOrderFlow = false
                                    presentationMode.wrappedValue.dismiss()
                                }
                                
                            } else {
                                showingAlert = true
                                alertText = response.message ?? response.error ?? "Ocorreu um erro"
                            }
                          
                        case let .failure(error):
                            isLoading = false
                            showingAlert = true
                            alertText = error.localizedDescription
                        }
                        
                    }
                }) {
                    Text("Continuar")
                        .foregroundColor(.white)
                }
                .padding()
                
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(
                    title: Text(""),
                    message: Text(alertText),
                    dismissButton: .default(Text("Ok"))
                )
            })
        }
    }
}

