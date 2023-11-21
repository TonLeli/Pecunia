//
//  BottomSheetCodeView.swift
//  pecunia
//
//  Created by Wellington on 29/10/23.
//

import SwiftUI

struct BottomSheetCodeView: View {
    
    @State private var isShowingCode: Bool = false
    @State private var isLoading = false
    @State private var isPasswordEnabled = false
    @Binding var isShowingPassword: Bool
    @Binding var isShowingEmailScreen: Bool
    @Binding var isShowingCodeScreen: Bool
    @FocusState var focused: Bool?
    @State private var showingAlert = false
    @State private var errorMessage = ""
    var viewModel: RecoveryPasswordViewModel
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    isShowingPassword = false
                    isShowingEmailScreen = false
                    isShowingCodeScreen = false
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
            
            
            Text("Insira o código\nenviado no e-mail...")
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            Text(viewModel.currentEmail)
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            

            OtpView(activeIndicatorColor: Color.black,
                    inactiveIndicatorColor: Color.gray,
                    length: 4, doSomething: { value in
                
                viewModel.resetPassword(code: value) { (result: Result<CommonResponse, Error>) in
                    switch result {
                    case .success(let value):
                        if value.status > 202 {
                            showingAlert = true
                            errorMessage = value.message ?? value.error ?? "Ocorreu um erro, tente novamente mais tarde"
                            return
                        }
                        showingAlert = true
                        errorMessage = value.message ??  value.error ?? "Ocorreu um erro, tente novamente mais tarde"
                        
                        isShowingPassword = false
                        isShowingEmailScreen = false
                        isShowingCode = false
                      
                    case .failure(_):
                        showingAlert = true
                        errorMessage = "Ocorreu um erro"
                    }
                }
                      
            })
            .padding()

        }
        .background(Color.white)
        .alert(isPresented: $showingAlert, content: {
            Alert(
                title: Text(""),
                message: Text(errorMessage),
                dismissButton: .default(Text("Ok"))
            )
        })
        
        
        
    }
}

//#Preview {
//    BottomSheetCodeView()
//}
