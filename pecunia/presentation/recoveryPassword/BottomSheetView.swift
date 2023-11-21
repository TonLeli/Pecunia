//
//  BottomSheetView.swift
//  pecunia
//
//  Created by Wellington on 27/10/23.
//

import SwiftUI

struct BottomSheetView: View {
    @State private var email: String = ""
    @ObservedObject var viewModel = RecoveryPasswordViewModel()
    @Binding var isShowing: Bool
    @State private var isShowingPassword: Bool = false
    @State private var isLoading = false
    @FocusState var focused: Bool?
    @State private var showingAlert = false
    @State private var errorMessage = ""
    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isShowing = false
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: 50, maxHeight: 50)
                        Text("X")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, 40)
                .padding(.bottom, 40)
                
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            
            Text("Esqueceu a\nSenha ? ...")
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            Text("Não se preocupe! Isso acontece. \nPor favor, informe o email associado a sua conta")
                .font(.system(size: 18, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            
            TextField("E-mail", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .padding(.top, 20)
                .focused($focused, equals: true)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.focused = true
                    }
                }
            
            LoadingButton(isLoading: $isLoading, action: {
                isLoading = true
                
                viewModel.sendCodeEmail(email: email) { (result: Result<CommonResponse, Error>) in
                    switch result {
                    case .success(let success):
                        if success.status >= 200 && success.status <= 210 {
                            viewModel.currentEmail = email
                            isShowingPassword = true
                        } else {
                            showingAlert = true
                            errorMessage = success.message ?? success.error ?? "Ocorreu um erro desconhecido"
                        }
                        
                        isLoading = false
                    case .failure(_):
                        isLoading = false
                        break;
                    }
                
                }
            }) {
                Text("Avançar")
                    .foregroundColor(.white)
            }
            
            .padding(.horizontal, 50)
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
        }
        .background(Color.white)
        .sheet(isPresented: $isShowingPassword) {
            BottomsheetPasswordView(
                isShowingPassword: $isShowingPassword,
                isShowingEmailScreen: $isShowing,
                viewModel: viewModel
            )
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(
                title: Text("Opss..."),
                message: Text(errorMessage),
                dismissButton: .default(Text("Ok"))
            )
        })
        
        
        
    }
}
