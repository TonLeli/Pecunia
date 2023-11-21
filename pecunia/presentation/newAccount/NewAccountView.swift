//
//  NewAccountView.swift
//  pecunia
//
//  Created by Wellington on 30/10/23.
//

import SwiftUI

struct NewAccountView: View {

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @ObservedObject var viewModel = NewAccountViewModel()
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
            
            
            Text("Nova Conta ...")
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            
            TextField("Nome", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .focused($focused, equals: true)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.focused = true
                    }
                }
            
            TextField("E-mail", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .disableAutocorrection(true)
                  .autocapitalization(.none)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.focused = true
                    }
                }
            
            SecureField("Senha", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.focused = true
                    }
                }
            
            LoadingButton(isLoading: $isLoading, action: {
                isLoading = true
                
                
                viewModel.createAccount(email: email, name: name, password: password)  { (result: Result<CommonResponse, Error>) in
                    switch result {
                    case .success(let success):
                        if success.status >= 200 && success.status <= 210 {
                            errorMessage = success.message ?? success.error ?? "Ocorreu um erro"
                            showingAlert = true
                            
                            isShowing = false
                        } else {
                            showingAlert = true
                            errorMessage = success.message ?? success.error ?? "Ocorreu um erro desconhecido"
                            isShowing = false
                        }
                        isLoading = false
                    case .failure(_):
                        isLoading = false
                        errorMessage = "Ocorreu um erro desconhecido"
                        showingAlert = true
                        isShowing = false
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
//    NewAccountView()
//}
