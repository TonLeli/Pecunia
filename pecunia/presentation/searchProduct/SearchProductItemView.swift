//
//  SearchProductItemView.swift
//  pecunia
//
//  Created by Wellington on 02/11/23.
//

import SwiftUI

struct ProductListView: View {
    let products: [ProductResult]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(products, id: \.nome) { product in
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

                            Text(product.mercado)
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            Text(product.nome)
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                            Text("R$ \(product.preco)")
                                .foregroundColor(.black)
                                .font(.system(size: 20).weight(.bold))
                                .padding(.top, 10)
                        }
                        Spacer()
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


