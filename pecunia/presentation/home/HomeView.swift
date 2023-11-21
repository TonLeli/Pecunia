//
//  HomeView.swift
//  pecunia
//
//  Created by Wellington on 30/10/23.
//

import SwiftUI

struct HomeView: View {
    @State private var emailText: String = ""
    
    @State var isShowingOrderFlow: Bool = false

    var body: some View {
        ZStack  {
            VStack(spacing: .zero) { Color("orangeColor"); Color.black }
            
            ScrollView {
                VStack {
                    Text("Bem-vindo...")
                        .font(.system(size: 30, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 120)
                        .padding(.leading, 40)
                    
                    Text(emailText)
                        .font(.system(size: 24, weight: .light))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 40)
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: UpdateOrdersView()) {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(height: 100)
                                .foregroundColor(.white)
                                .overlay(
                                    ZStack {
                                        HStack {
                                            VStack {
                                                Text("Minhas compras")
                                                    .foregroundColor(.black)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.leading, 20)
                                                    .font(.system(size: 20).bold())
                                                
                                                Text("Gerenciar e adicionar\nnovas compras")
                                                    .foregroundColor(.black)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.leading, 20)
                                                    .font(.system(size: 14))
                                                   
                                            }
                                            Spacer()
                                            Image(systemName: "bag")
                                                .foregroundColor(.black)
                                                .padding(.trailing, 20)
                                                .font(.system(size: 25))
                                        }
                                    }
                                )
                                .padding(.horizontal, 20)
                        }
                        
                        NavigationLink(destination: MyOrdersView()) {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(height: 100)
                                .foregroundColor(.white)
                                .overlay(
                                    ZStack {
                                        HStack {
                                            VStack {
                                                Text("Resumo de compras")
                                                    .foregroundColor(.black)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.leading, 20)
                                                    .font(.system(size: 20).bold())
                                                
                                                Text("Compare o preço\nde suas compras")
                                                    .foregroundColor(.black)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.leading, 20)
                                                    .font(.system(size: 14))
                                                   
                                            }
                                            Spacer()
                                            Image(systemName: "cube.box.fill")
                                                .foregroundColor(.black)
                                                .padding(.trailing, 20)
                                                .font(.system(size: 25))
                                        }
                                    }
                                )
                                .padding(.horizontal, 20)
                        }
                        
                        NavigationLink(destination: SearchProductView()) {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(height: 100)
                                .foregroundColor(.white)
                                .overlay(
                                    ZStack {
                                        HStack {
                                            VStack {
                                                Text("Pesquisa por produto")
                                                    .foregroundColor(.black)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.leading, 20)
                                                    .font(.system(size: 20).bold())
                                                
                                                Text("Consultar o preço\ndos produtos")
                                                    .foregroundColor(.black)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.leading, 20)
                                                    .font(.system(size: 14))
                                                   
                                            }
                                            Spacer()
                                            Image(systemName: "cart.fill.badge.plus")
                                                .foregroundColor(.black)
                                                .padding(.trailing, 20)
                                                .font(.system(size: 25))
                                
                                        }
                                    }
                                )
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            if let email = UserDefaults.standard.string(forKey: "currentName") {
                emailText = email
            }
        }
    }
}


struct MinhasComprasView: View {
    var body: some View {
        Text("Minhas Compras")
    }
}

struct ResumoComprasView: View {
    var body: some View {
        Text("Resumo de Compras")
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
