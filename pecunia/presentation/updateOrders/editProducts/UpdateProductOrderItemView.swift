//
//  UpdateProductOrderItemView.swift
//  pecunia
//
//  Created by Wellington on 18/11/23.
//

import SwiftUI

struct UpdateProductOrderItemView: View {
    @Binding var updateProductSelections: [UpdateProductSelection]
    let products: [EditOrderItemListItem]
    @State private var isLoading = false
    @Binding var productsToSendToAPI: [UpdateProductSelection]
    @State private var selectionChange = UUID()
    var currentSavedProducts: [EditOrderItemListItem]
    
    var body: some View {
        ScrollView {
            ForEach(products, id: \.idProduto) { product in
                let selectionIndex = updateProductSelections.firstIndex { $0.nome == product.nome }
                var selectedQuantity = selectionIndex != nil ? updateProductSelections[selectionIndex!].quantidade : 0
                var acao = selectionIndex != nil ? updateProductSelections[selectionIndex!].acao : "alterar"
                
                HStack {
                    AsyncImage(url: URL(string: product.imagem)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                        case .failure:
                            Text("Erro ao carregar a imagem")
                        @unknown default:
                            Text("Erro ao carregar a imagem")
                        }
                    }
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .onAppear {
                        updateProductSelections = products.map { product in
                            if let existingSelection = updateProductSelections.first(where: { $0.nome == product.nome }) {
                                return existingSelection
                            } else {
                                return UpdateProductSelection(nome: product.nome, imagem: product.imagem, quantidade: 0, acao: "alterar", idProduto: product.idProduto)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(product.nome)
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                if selectedQuantity > 0 {
                                    selectedQuantity -= 1
                                    acao = selectedQuantity > 0 ? "alterar" : "remover"
                                    updateProductSelections.removeAll { $0.nome == product.nome }
                                    updateProductSelections.append(UpdateProductSelection(nome: product.nome, imagem: product.imagem, quantidade: selectedQuantity, acao: acao, idProduto: product.idProduto))
                                    
                                    
                                    checkAndAddToAPIList(product: product, quantity: selectedQuantity)
                                }
                            }) {
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            
                            Text("\(selectedQuantity)")
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            Button(action: {
                                selectedQuantity += 1
                                acao = "alterar"
                                updateProductSelections.removeAll { $0.nome == product.nome }
                                updateProductSelections.append(UpdateProductSelection(nome: product.nome, imagem: product.imagem, quantidade: selectedQuantity, acao: acao, idProduto: product.idProduto))
                                
                                checkAndAddToAPIList(product: product, quantity: selectedQuantity)
                            }) {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .padding()
                    }
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
                .onAppear {
                    updateProductSelections = products.map { UpdateProductSelection(nome: $0.nome, imagem: $0.imagem, quantidade: $0.quantidade, acao: String(), idProduto: $0.idProduto)
                    }

                }
                
            
            }
        }
    }
    
    private func checkAndAddToAPIList(product: EditOrderItemListItem, quantity: Int) {
        if let originalProduct = products.first(where: { $0.nome == product.nome }) {
            if quantity != originalProduct.quantidade {
                var action = quantity > 0 ? "alterar" : "remover"
            
                if currentSavedProducts.first(where: {$0.nome == product.nome}) == nil && !currentSavedProducts.isEmpty {
                    action = "adicionar"
                }
                    
                if let existingSelectionIndex = productsToSendToAPI.firstIndex(where: { $0.nome == product.nome }) {
                    if productsToSendToAPI[existingSelectionIndex].quantidade != quantity || productsToSendToAPI[existingSelectionIndex].acao != action {
                        productsToSendToAPI[existingSelectionIndex] = UpdateProductSelection(nome: product.nome, imagem: product.imagem, quantidade: quantity, acao: action, idProduto: product.idProduto)
                    } else {
                        productsToSendToAPI.remove(at: existingSelectionIndex)
                    }
                } else {
                    if quantity > 0 {
                        if currentSavedProducts.isEmpty {
                            if products.first(where: { $0.nome == product.nome }) == nil {
                                productsToSendToAPI.append(UpdateProductSelection(nome: product.nome, imagem: product.imagem, quantidade: quantity, acao: "adicionar", idProduto: product.idProduto))
                            } else {
                                productsToSendToAPI.append(UpdateProductSelection(nome: product.nome, imagem: product.imagem, quantidade: quantity, acao: "alterar", idProduto: product.idProduto))
                            }
                        } else {
                            if currentSavedProducts.first(where: { $0.nome == product.nome }) == nil {
                                productsToSendToAPI.append(UpdateProductSelection(nome: product.nome, imagem: product.imagem, quantidade: quantity, acao: "adicionar", idProduto: product.idProduto))
                    
                            } else {
                                productsToSendToAPI.append(UpdateProductSelection(nome: product.nome, imagem: product.imagem, quantidade: quantity, acao: "alterar", idProduto: product.idProduto))
                            }
                        }
                    }
                }
            } else {
                productsToSendToAPI.removeAll { $0.nome == product.nome }
            }
        }
    }




}
