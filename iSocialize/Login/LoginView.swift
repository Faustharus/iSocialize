//
//  LoginView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 02/01/2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginVM = LoginViewModelImpl(service: LoginServiceImpl())
    
    @State private var toSeePassword: Bool = false
    @State private var toForgotPassword: Bool = false
    
    @Binding var switchPage: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(systemName: "bubble.left.and.text.bubble.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.3)
                Text("Where socializing feels rewarding")
                    .font(.headline)
                
                Spacer().frame(minHeight: 8, maxHeight: 16)
                
                TextFieldViewCompo(stateProperty: $loginVM.credentials.email, textFieldTitle: "Email", textFieldPlaceholder: "Email")
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            if !loginVM.credentials.email.isEmpty {
                                Button {
                                    self.loginVM.credentials.email = ""
                                } label: {
                                    Text("Reset")
                                }
                            }
                        }
                    }
                
                Spacer().frame(minHeight: 16, maxHeight: 32)
                
                SecureFieldViewCompo(stateProperty: $loginVM.credentials.password, toSeePassword: $toSeePassword, secureFieldTitle: "Password", secureFieldPlaceholder: "Password")
                    .autocorrectionDisabled()
                
                Button {
                    toForgotPassword = true
                } label: {
                    Text("Forgot Password ?")
                        .foregroundStyle(.secondary)
                }
                .offset(x: geo.frame(in: .global).midX - 95)
                .buttonStyle(.plain)
                
                Spacer().frame(height: geo.size.height * 0.05)
                
                ActionButtonViewCompo(buttonText: "LogIn", buttonColor: .cyan, buttonWidth: geo.size.width * 0.8, buttonHeight: geo.size.height * 0.1) {
                    if checkEmailFormat(newValue: loginVM.credentials.email) {
                        loginVM.login()
                    }
                }
                .disabled(loginVM.credentials.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || loginVM.credentials.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                Spacer()
                
                HStack(spacing: 0) {
                    Text("Not yet an account ? - ")
                    Button {
                        switchPage.toggle()
                    } label: {
                        Text("SignUp")
                    }
                }
                .padding(.vertical, 15)
            }
            .containerRelativeFrame(.horizontal) { width, size in
                width
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .navigationTitle("iSocialize")
        .fullScreenCover(isPresented: $toForgotPassword) {
            ForgotPasswordView()
        }
        .alert(isPresented: $loginVM.hasError) {
            if case .failed(let error) = loginVM.state {
                return Alert(title: Text("Your credentials aren't correct"), message: Text("\(error.localizedDescription)"))
            } else {
                return Alert(title: Text("Error"), message: Text("Something went wrong"))
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView(switchPage: .constant(false))
    }
}

// MARK: Functions
extension LoginView {
    
    private func checkEmailFormat(newValue: String) -> Bool {
        let emailRegex = try! Regex("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z0-9]{2,64}")
        
        do {
            if newValue.contains(emailRegex) {
                print("Valid Email Format")
                return true
            }
        }
        print("Email Format Invalid")
        return false
    }
    
}
