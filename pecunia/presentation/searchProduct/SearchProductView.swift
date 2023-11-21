//
//  SearchProductView.swift
//  pecunia
//
//  Created by Wellington on 31/10/23.
//

import SwiftUI

struct SearchProductView: View {
    @ObservedObject var viewModel = SearchProductViewModel()
    @State private var productSearch: String = ""
    @State private var timer: Timer?
    @State var shouldShowLoading = false

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
                                            self.shouldShowLoading = true
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
                    ProductListView(products: itemList)
                        .onAppear()  {
                            shouldShowLoading  = false
                        }
                       
                    
                }
            }
        }
    }
}


#Preview {
    SearchProductView()
}
