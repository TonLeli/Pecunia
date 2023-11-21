//
//  OrderItemView.swift
//  pecunia
//
//  Created by Wellington on 07/11/23.
//

import SwiftUI

struct OrderItemView: View {
    let orderList: [OrderData]
    @Binding var isLoading: Bool
    let onItemClick: (String) -> Void
    
    @State private var selectedItem: String = ""
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(orderList, id: \.nomeCompra) { orderItem in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Nome da compra")
                                .font(.system(size: 14).weight(.light))
                                .foregroundColor(.black)
                            Text(orderItem.nomeCompra)
                                .font(.system(size: 24).bold())
                                .foregroundColor(.black)
                        }
                        .padding(10)
                        Spacer()

                        if isLoading && selectedItem == orderItem.nomeCompra {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .foregroundColor(.black)
                                .padding(.trailing, 10)
                        } else {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .padding(.trailing, 10)
                        }
                    }
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .onTapGesture {
                        isLoading = true
                        selectedItem = orderItem.nomeCompra
                        onItemClick(orderItem.nomeCompra)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
            }
        }
    }
}
