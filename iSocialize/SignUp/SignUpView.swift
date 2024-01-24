//
//  SignUpView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 02/01/2024.
//

import SwiftUI

enum FocusedSignUp: Hashable {
    case fullname, email, password, confirmPassword
}

struct SignUpView: View {
    
    @StateObject private var registerVM = SignUpViewModelImpl(service: SignUpServiceImpl())
    
    @State private var onBoardingStatus: Int = 0
    @State private var toSeePassword: Bool = false
    @State private var toSeeConfirmPassword: Bool = false
    
    @Binding var switchPage: Bool
    
    @FocusState var focusedSignUp: FocusedSignUp?
    
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
                
                switch onBoardingStatus {
                case 1:
                    passwords
                default:
                    emailAndName
                }
                
                Spacer().frame(height: geo.size.height * 0.09)
                
                HStack {
                    if onBoardingStatus == 1 {
                        ActionButtonViewCompo(buttonText: "Back", buttonColor: .red, buttonWidth: onBoardingStatus == 1 ? geo.size.width * 0.4 : geo.size.width * 0.8, buttonHeight: geo.size.height * 0.1) {
                            withAnimation(.spring()) {
                                onBoardingStatus -= 1
                            }
                        }
                        .shadow(color: .black, radius: 1, x: -0.5, y: -1)
                        .padding(.horizontal, onBoardingStatus == 1 ? 10 : 30)
                    }
                    
                    ActionButtonViewCompo(buttonText: onBoardingStatus == 1 ? "SignUp" : "Next", buttonColor: .cyan, buttonWidth: onBoardingStatus == 1 ? geo.size.width * 0.4 : geo.size.width * 0.8, buttonHeight: geo.size.height * 0.1) {
                        withAnimation(.spring()) {
                            if onBoardingStatus == 1 {
                                if checkEmailFormat(newValue: registerVM.userDetails.email) {
                                    registerVM.register()
                                }
                            } else {
                                onBoardingStatus += 1
                            }
                        }
                    }
                    .shadow(color: .black, radius: 1, x: -0.5, y: -1)
                    .disabled(onBoardingStatus == 1 && canSignIn())
                    .padding(.horizontal, onBoardingStatus == 1 ? 10 : 30)
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    Text("Already have an account ? - ")
                    Button {
                        switchPage.toggle()
                    } label: {
                        Text("LogIn")
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
    }
}

#Preview {
    NavigationStack {
        SignUpView(switchPage: .constant(false))
    }
}

// MARK: View Components
extension SignUpView {
    
    private var passwords: some View {
        VStack {
            SecureFieldViewCompo(stateProperty: $registerVM.userDetails.password, toSeePassword: $toSeePassword, secureFieldTitle: "Password", secureFieldPlaceholder: "Password")
                .keyboardType(.default)
                .autocorrectionDisabled()
                .focused($focusedSignUp, equals: .password)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        if focusedSignUp == .password {
                            Button {
                                self.registerVM.userDetails.password = ""
                            } label: {
                                Text("Reset")
                            }
                        }
                    }
                }
            
            Spacer().frame(minHeight: 16, maxHeight: 32)
            
            SecureFieldViewCompo(stateProperty: $registerVM.userDetails.confirmPassword, toSeePassword: $toSeeConfirmPassword, secureFieldTitle: "Confirm Password", secureFieldPlaceholder: "Confirm Password")
                .keyboardType(.default)
                .autocorrectionDisabled()
                .focused($focusedSignUp, equals: .confirmPassword)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        if focusedSignUp == .confirmPassword {
                            Button {
                                self.registerVM.userDetails.confirmPassword = ""
                            } label: {
                                Text("Reset")
                            }
                        }
                    }
                }
        }
    }
    
    private var emailAndName: some View {
        VStack {
            TextFieldViewCompo(stateProperty: $registerVM.userDetails.email, textFieldTitle: "Email", textFieldPlaceholder: "Email")
                .keyboardType(.default)
                .autocorrectionDisabled()
                .focused($focusedSignUp, equals: .email)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        if focusedSignUp == .email {
                            Button {
                                self.registerVM.userDetails.email = ""
                            } label: {
                                Text("Reset")
                            }
                        }
                    }
                }
            
            Spacer().frame(minHeight: 16, maxHeight: 32)
            
            TextFieldViewCompo(stateProperty: $registerVM.userDetails.fullName, textFieldTitle: "Full Name", textFieldPlaceholder: "Full Name")
                .keyboardType(.default)
                .autocorrectionDisabled()
                .focused($focusedSignUp, equals: .fullname)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        if focusedSignUp == .fullname {
                            Button {
                                self.registerVM.userDetails.fullName = ""
                            } label: {
                                Text("Reset")
                            }
                        }
                    }
                }
        }
    }
    
}


// MARK: Funtions
extension SignUpView {
    
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
    
    private func checkPasswordValidity(newValue: String) -> Bool {
        let pwdRegex = try! Regex("\\A(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-Z0-9!@#$%^&*]{12,}\\z")
        
        do {
            if newValue.contains(pwdRegex) {
                print("Password Format Valid")
                return true
            }
        }
        print("Minimum of 12 characters required \nAt least, 1 Uppercase Letter, 1 Smallcase Letter, 1 Number and 1 Special Character")
        return false
    }
    
    private func canSignIn() -> Bool {
        registerVM.userDetails.fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || registerVM.userDetails.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || registerVM.userDetails.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || registerVM.userDetails.confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
