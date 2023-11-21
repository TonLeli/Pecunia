//
//  MyOrdersView.swift
//  pecunia
//
//  Created by Wellington on 07/11/23.
//

import SwiftUI

struct MyOrdersView: View {
    
    let viewModel = MyOrdersViewModel()
    @State var ordersResponse: Order? = nil
    @State var orderResponseError: String? = nil
    @State var showLoading: Bool = false
    @State var showBottomSheet: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack(spacing: .zero) { Color("orangeColor"); Color.black }
                .ignoresSafeArea()

            VStack {
                Text("Aqui estão\nsuas compras")
                    .font(.system(size: 30).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 40)
                    .padding(.top, 20)
                
                if let itemList = ordersResponse?.data {
                    OrderItemView(orderList: itemList, isLoading: $showLoading) { orderName in
                        
                        viewModel.getOrderValue(orderName: orderName) { (result: Result<OrderValue, Error>) in
                            switch result {
                            case let .success(response):
                                viewModel.ordersValue = response
                                showLoading = false
                                showBottomSheet =  true
                                
                            case let .failure(error):
                                showLoading = false
                                break;
                         
                            }
                        }
                    }
                }
                
                if let error = orderResponseError {
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: .infinity, height: 100)
                        .padding(.trailing, 30)
                        .overlay{
                            Text("\(error)")
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                        }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            viewModel.getOrders {  (result: Result<Order, Error>) in
                switch result {
                case .success(let response):
                    if response.status >= 200 && response.status <= 210 {
                        self.ordersResponse = response
                        
                    } else {
                        self.orderResponseError = response.message ?? "Ocorreu um erro desconhecido"
                    }
                case .failure(let error):
                    self.orderResponseError = error.localizedDescription
                }
            }
        }.sheet(isPresented: $showBottomSheet) {
            if let orderValue = viewModel.ordersValue {
                MyOrdersBottomSheet(orderValue: orderValue)
            }
           
        }
    }
}

#Preview {
    MyOrdersView()
}
