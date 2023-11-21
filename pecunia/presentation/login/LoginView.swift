//
//  ContentView.swift
//  pecunia
//
//  Created by Wellington on 27/10/23.
//

import SwiftUI

struct LoginView: View {
    @State private var isPasswordResetSheetPresented = false
    @State private var isShowingNewAccount = false
    @State private var keyboardHeight: CGFloat = 0
    @ObservedObject var viewModel = LoginViewModel()
    @State private var showingAlert = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var showHome = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: .zero) { Color("orangeColor"); Color.black }
                ScrollView {
                    VStack {
                        
                        Spacer(minLength: 30)
                        
                        Image("pecunia")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                        
                        Spacer(minLength: 30)
                        
                        HStack {
                            Spacer(minLength: 30)
                            VStack {
                                Text("Entre com a sua conta")
                                    .font(.system(size: 24, weight: .semibold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 20)
                                
                                TextField("E-mail", text: $emailText)
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.bottom, 5)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                
                                
                                SecureField("Senha", text: $passwordText)
                                    .textFieldStyle(.roundedBorder)
                                
                                
                                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $showHome) {
                                    
                                    LoadingButton(isLoading: $isLoading, action: {
                                        isLoading = true
                                        
                                        viewModel.login(email: emailText, password: passwordText)  { (result: Result<Login, Error>) in
                                            switch result {
                                            case .success(let success):
                                                if success.status >= 200 && success.status <= 210 {
                                                    
                                                    UserDefaults.standard.setValue(emailText, forKey: "currentEmail")
                                                    UserDefaults.standard.setValue(passwordText, forKey: "currentPassword")
                                                    UserDefaults.standard.setValue(success.uid ?? " ", forKey: "currentUid")
                                                    
                                                    UserDefaults.standard.setValue(success.nome, forKey: "currentName")
                                                    
                                                    isLoading = false
                                                    showHome = true
                                                    
                                                } else {
                                                    showingAlert = true
                                                    errorMessage = success.message ?? success.error ?? "Ocorreu um erro desconhecido"
                                                    
                                                }
                                                isLoading = false
                                            case .failure(_):
                                                isLoading = false
                                                errorMessage = "Ocorreu um erro desconhecido"
                                                
                                                break;
                                            }
                                            
                                        }
                                        
                                        
                                    }) {
                                        
                                        Text("Avançar")
                                            .foregroundColor(.white)
                                    }
                                    .buttonStyle(FilledButtonStyle())
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                                    
                                }
                                
                                Button("Criar nova conta") {
                                    isShowingNewAccount = true
                                    
                                }
                                .padding(.top, 20)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color("orangeColor"))
                                
                                Button("Redefinir senha") {
                                    isPasswordResetSheetPresented = true
                                }
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.black)
                                .padding(.top, 5)
                                
                                
                            }
                            .padding()
                            .background(
                                Color.white
                                    .cornerRadius(10)
                            )
                            Spacer(minLength: 30)
                        }
                    }
                }
                
                
            }
            
            .ignoresSafeArea()
            .sheet(isPresented: $isPasswordResetSheetPresented) {
                BottomSheetView(isShowing: $isPasswordResetSheetPresented)
            }
            .sheet(isPresented: $isShowingNewAccount) {
                NewAccountView(isShowing: $isShowingNewAccount)
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(
                    title: Text(""),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("Ok"))
                )
            })
            .onAppear {
                if let email = UserDefaults.standard.string(forKey: "currentEmail") {
                    emailText = email
                }
                
                if let password = UserDefaults.standard.string(forKey: "currentPassword") {
                    passwordText = password
                }
                
            }
        }
    }
}

#Preview {
    LoginView()
}
