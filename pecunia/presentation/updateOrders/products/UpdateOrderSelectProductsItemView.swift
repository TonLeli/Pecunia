//
//  UpdateOrderSelectProductsItemView.swift
//  pecunia
//
//  Created by Wellington on 08/11/23.
//

import SwiftUI

struct UpdateOrderSelectProductsItemView: View {
    @Binding var productSelections: [ProductSelection]
    let products: [ProductOrderResponseItem]
    @State private var isLoading = false
    

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(products, id: \.nome) { product in
                    let selectionIndex = productSelections.firstIndex { $0.product.nome == product.nome }
                    let selectedQuantity = selectionIndex != nil ? productSelections[selectionIndex!].selectedQuantity : 0
                    
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

                        VStack(alignment: .leading) {
                            Text(product.nome)
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    if let index = productSelections.firstIndex(where: { $0.product.nome == product.nome }) {
                                        if productSelections[index].selectedQuantity > 0 {
                                            productSelections[index].selectedQuantity -= 1
                                        }
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
                                    if let index = productSelections.firstIndex(where: { $0.product.nome == product.nome }) {
                                        productSelections[index].selectedQuantity += 1
                                    } else {
                                        let newSelection = ProductSelection(product: product, selectedQuantity: 1)
                                        productSelections.append(newSelection)
                                    }
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
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
            }
            
            
        }
    }
}
