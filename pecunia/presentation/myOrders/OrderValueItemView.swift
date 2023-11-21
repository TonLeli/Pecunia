//
//  OrderValueItemView.swift
//  pecunia
//
//  Created by Wellington on 18/11/23.
//

import SwiftUI

struct OrderValueItemView: View {
    let orderValue: [OrderValueMarket]
    
    let viewModel = MyOrdersViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(orderValue, id: \.marketName) { orderItem in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(orderItem.marketName)
                                .font(.system(size: 14).weight(.light))
                                .foregroundColor(.black)
                            Text(orderItem.marketValue.toCurrencyString())
                                .font(.system(size: 24).bold())
                                .foregroundColor(.black)
                        }
                        .padding(10)
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

