//
//  BottomsheetPasswordView.swift
//  pecunia
//
//  Created by Wellington on 29/10/23.
//

import SwiftUI

struct BottomsheetPasswordView: View {
    @State private var isShowingCode: Bool = false
    @State private var isLoading = false
    @FocusState var focused: Bool?
    @Binding var isShowingPassword: Bool
    @Binding var isShowingEmailScreen: Bool
     var viewModel: RecoveryPasswordViewModel
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var errorMessage = ""
    
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    isShowingEmailScreen = false
                   isShowingPassword = false
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
            
            
            Text("Sua nova senha ...")
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            Text("A senha deve conter pelo menos 8 caracteres, incluindo pelo menos um dígito e um caractere especial")
                .font(.system(size: 18, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            
            SecureField("Senha", text: .constant(""))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .focused($focused, equals: true)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.focused = true
                    }
                }
            
            SecureField("Confirme a senha", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
                .focused($focused, equals: true)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.focused = true
                    }
                }
            
            LoadingButton(isLoading: $isLoading, action: {
                
                if viewModel.isValidPassword(password: password)  {
                    isShowingCode  = true
                    viewModel.currentPassword = password
                } else {
                    showingAlert = true
                    errorMessage = "A senha deve conter pelo menos 8 caracteres, incluindo pelo menos um dígito e um caractere especial"
                }
                
            }) {
                Text("Confirmar")
                    .foregroundColor(.white)
            }
            
            .padding(.horizontal, 50)
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
        }
        .background(Color.white)
        .sheet(isPresented: $isShowingCode) {
            BottomSheetCodeView(
                isShowingPassword: $isShowingPassword,
                isShowingEmailScreen: $isShowingEmailScreen,
                isShowingCodeScreen: $isShowingCode,
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


//#Preview {
//    BottomsheetPasswordView()
//}
