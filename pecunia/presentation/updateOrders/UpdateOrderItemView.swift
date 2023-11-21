//
//  UpdateOrderItemView.swift
//  pecunia
//
//  Created by Wellington on 07/11/23.
//

import SwiftUI

struct UpdateOrderItemView: View {
    var orderList: [OrderData]
    
    @State private var isLoading = false
    
    var didDeleteItem: (OrderData) -> Void
    var didSelectOrder: (String) -> Void
    
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

                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 5)
                        } else {
                            Image(systemName: "trash")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .padding(.trailing, 10)
                                .onTapGesture {
                                    isLoading = true
                                    didDeleteItem(orderItem)
                                }
                        }
                    }
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .onTapGesture {
                        didSelectOrder(orderItem.nomeCompra)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
            }
        }
    }
}
