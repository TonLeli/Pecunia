//
//  UpdateOrdersView.swift
//  pecunia
//
//  Created by Wellington on 07/11/23.
//

import SwiftUI
import Lottie

struct UpdateOrdersView: View {
    
    let viewModel = MyOrdersViewModel()
    let deleteItemViewModel = UpdateOrderViewModel()
    @State var ordersResponse: Order? = nil
    @State var orderResponseError: String? = nil
    @State private var shouldShowError: Bool = false
    @State private var isLoading = false
    @State private var showingAlert = false
    @State private var isShowingEmailBottomSheet = false
    @State private var isShowingProductScreen = false
    @State private var selectedOrderName = ""
    @State private var showingAlertDelete = false
    @State private var alertMessage = ""
    
    @State private var showOrderEdit = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            VStack(spacing: .zero) { Color("orangeColor"); Color.black }
                .ignoresSafeArea()
            
            
            if isLoading {
                LottieLoading(loopMode: .loop)
                    .scaleEffect(0.4)
            }  else {
                
                VStack {
                    Text("Aqui estão\nsuas compras")
                        .font(.system(size: 30).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 40)
                        .padding(.top, 20)
                    
                    if let itemList = ordersResponse?.data {
                        UpdateOrderItemView(orderList: itemList) { deletedItem in
                            deleteItemViewModel.deleteItem(
                                orderName: deletedItem.nomeCompra) { (result: Result<CommonResponse, Error>) in
                                    switch result {
                                    case let .success(response):
                                        if response.status >= 200 && response.status <= 210 {
                                            showingAlert = true
                                            alertMessage = "Compra excluída com sucesso."
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                presentationMode.wrappedValue.dismiss()
                                            }
                                          
                                        } else {
                                            showingAlert = true
                                            alertMessage = response.message ?? response.error ?? "Ocorreu um erro"
                                        }
                                    case let .failure(error):
                                        showingAlert = true
                                        alertMessage = error.localizedDescription
                                        
                                    }
                                }
                        } didSelectOrder: { orderName in
                            self.selectedOrderName = orderName
                            showOrderEdit = true
                        }
                    }
                    
                    
                    if(shouldShowError)  {
                        if let error = orderResponseError {
                            
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .frame(maxWidth: .infinity, maxHeight: 100)
                                .padding()
                                .overlay{
                                    Text("\(error)")
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                }
                        }
                    }
                    
                    LoadingButton(isLoading: $isLoading, action: {
                        
                        if ordersResponse?.isFull ?? false {
                            showingAlert = true
                            alertMessage = "Você pode adicionar até no máximo 3 compras."
                        } else {
                            isShowingEmailBottomSheet = true
                        }
                        
                    }) {
                        Text("Cadastrar compra")
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    
                    
                    NavigationLink("", destination: UpdateOrdersSelectProductsView(orderName: selectedOrderName, isShowingOrderFlow: $isShowingProductScreen), isActive: $isShowingProductScreen)
                        .opacity(0)
                    
                    NavigationLink("", destination: UpdateProductOrderView(orderName: selectedOrderName, isShowingOrderFlow: $showOrderEdit), isActive: $showOrderEdit)
                        .opacity(0)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(
                title: Text(""),
                message: Text(alertMessage),
                dismissButton: .default(Text("Ok"))
            )
        })
        .onAppear {
            isLoading = true
            viewModel.getOrders {  (result: Result<Order, Error>) in
                switch result {
                case .success(let response):
                    isLoading = false
                    if response.status >= 200 && response.status <= 210 {
                        shouldShowError = false
                        self.ordersResponse = response
                    } else {
                        shouldShowError = true
                        self.orderResponseError = response.message ?? "Ocorreu um erro desconhecido"
                    }
                case .failure(let error):
                    shouldShowError = true
                    isLoading = false
                    self.orderResponseError = error.localizedDescription
                }
            }
        }
        .sheet(isPresented: $isShowingEmailBottomSheet) {
            UpdateOrderBottomSheet(isShowing: $isShowingEmailBottomSheet) { selectedOrderName in
                isShowingEmailBottomSheet = false
                self.selectedOrderName = selectedOrderName
                isShowingProductScreen = true
            }
        }
    }
}


struct LottieLoading: UIViewRepresentable {
    let loopMode: LottieLoopMode
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: "loading")
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}

#Preview {
    MyOrdersView()
}
