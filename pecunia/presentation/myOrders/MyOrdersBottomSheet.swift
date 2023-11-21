//
//  MyOrdersBottomSheet.swift
//  pecunia
//
//  Created by Wellington on 18/11/23.
//

import SwiftUI

struct MyOrdersBottomSheet: View {
    let orderValue: OrderValue
    var body: some View {
        ZStack {
            VStack(spacing: .zero) { Color("orangeColor"); Color.black }
                .ignoresSafeArea()

            
        
            
            VStack {
                Spacer(minLength: 100)
                Text("Compare o\npreço de sua compra")
                    .font(.system(size: 30).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 40)
                    .padding(.top, 20)
                
                
                
                if let marketsList = orderValue.data.first?.listMarkets {
                    OrderValueItemView(orderValue: marketsList)
                }
    
            }
            .frame(maxWidth: .infinity)
        }
    }
}
