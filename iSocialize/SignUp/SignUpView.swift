//
//  SignUpView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 02/01/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var registerVM = SignUpViewModelImpl(service: SignUpServiceImpl())
    
    @State private var onBoardingStatus: Int = 0
    @State private var toSeePassword: Bool = false
    @State private var toSeeConfirmPassword: Bool = false
    
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
                            onBoardingStatus -= 1
                        }
                        .padding(.horizontal, onBoardingStatus == 1 ? 10 : 30)
                    }
                    
                    ActionButtonViewCompo(buttonText: onBoardingStatus == 1 ? "SignUp" : "Next", buttonColor: .cyan, buttonWidth: onBoardingStatus == 1 ? geo.size.width * 0.4 : geo.size.width * 0.8, buttonHeight: geo.size.height * 0.1) {
                        if onBoardingStatus < 1 {
                            onBoardingStatus += 1
                        } else {
                            onBoardingStatus = onBoardingStatus + 0
                            registerVM.register()
                        }
                    }
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
            Spacer().frame(minHeight: 16, maxHeight: 32)
            SecureFieldViewCompo(stateProperty: $registerVM.userDetails.confirmPassword, toSeePassword: $toSeeConfirmPassword, secureFieldTitle: "Confirm Password", secureFieldPlaceholder: "Confirm Password")
        }
    }
    
    private var emailAndName: some View {
        VStack {
            TextFieldViewCompo(stateProperty: $registerVM.userDetails.email, textFieldTitle: "Email", textFieldPlaceholder: "Email")
            Spacer().frame(minHeight: 16, maxHeight: 32)
            TextFieldViewCompo(stateProperty: $registerVM.userDetails.fullName, textFieldTitle: "Full Name", textFieldPlaceholder: "Full Name")
        }
    }
    
}
