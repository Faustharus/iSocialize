//
//  SignUpView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 02/01/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var registerVM = SignUpViewModelImpl(service: SignUpServiceImpl())
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var onBoardingStatus: Int = 0
    
    @Binding var switchPage: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(systemName: "bubble.left.and.bubble.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.5)
                Text("Where socializing feels rewarding")
                    .font(.system(size: 18, weight: .light, design: .rounded))
                    .italic()
                
                Spacer().frame(height: geo.size.height * 0.1)
                
                switch onBoardingStatus {
                case 1:
                    passwords
                default:
                    emailAndName
                }
                
                Spacer().frame(height: geo.size.height * 0.1)
                
                Button {
                    // TODO: <# Tap Instruction Here #>
                } label: {
                    Text("Forgot Password ?")
                        .hidden()
                }
                .offset(x: 85, y: 0.0)
                .buttonStyle(.plain)
                .foregroundStyle(.secondary)
                .disabled(true)
                
                Spacer().frame(height: 50)
                
                HStack {
                    if onBoardingStatus == 1 {
                        ZStack {
                            Capsule()
                                .fill(.red)
                            VStack {
                                Button {
                                    // TODO: <# Tap Instruction Here #>
                                    onBoardingStatus -= 1
                                } label: {
                                    Text("Back")
                                        .font(.system(size: 30, weight: .light, design: .rounded))
                                        .foregroundStyle(.white)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .frame(width: onBoardingStatus == 1 ? geo.size.width * 0.4 : geo.size.width * 0.8, height: geo.size.height * 0.1)
                        .padding(.horizontal, onBoardingStatus == 1 ? 10 : 30)
                    }
                    
                    ZStack {
                        Capsule()
                            .fill(.cyan)
                        VStack {
                            Button {
                                // TODO: <# Tap Instruction Here #>
                                if onBoardingStatus < 1 {
                                    onBoardingStatus += 1
                                } else {
                                    onBoardingStatus = onBoardingStatus + 0
                                    registerVM.register()
                                }
                            } label: {
                                Text(onBoardingStatus == 1 ? "SignUp" : "Next")
                                    .font(.system(size: 30, weight: .light, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(width: onBoardingStatus == 1 ? geo.size.width * 0.4 : geo.size.width * 0.8, height: geo.size.height * 0.1)
                    .padding(.horizontal, onBoardingStatus == 1 ? 10 : 30)
                }
                
                Spacer().frame(height: 30)
                
                HStack(spacing: 0) {
                    Text("Have an account already ? - ")
                    
                    Button {
                        switchPage.toggle()
                    } label: {
                        Text("Log")
                    }
                }
            }
            .padding(.vertical)
            .navigationTitle("iSocialize")
        }
    }
}

#Preview {
    NavigationStack {
        SignUpView(switchPage: .constant(false))
    }
}

// MARK: View Components
extension SignUpView {
    
    private var emailAndName: some View {
        GeometryReader { geo in
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email")
                        .font(.title.bold())
                        .padding(.leading, 5)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                        VStack {
                            TextField("Email", text: $registerVM.userDetails.email)
                                .padding(.leading)
                        }
                    }
                    .frame(width: geo.frame(in: .local).size.width * 0.8, height: 45)
                }
                
                Spacer().frame(height: geo.size.height * 0.15)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Full Name")
                        .font(.title.bold())
                        .padding(.leading, 5)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                        VStack {
                            TextField("Full Name", text: $registerVM.userDetails.fullName)
                                .padding(.leading)
                        }
                    }
                    .frame(width: geo.frame(in: .local).size.width * 0.8, height: 45)
                }
            }
            .padding(.horizontal, 40)
        }
    }
    
    
    private var passwords: some View {
        GeometryReader { geo in
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Password")
                        .font(.title.bold())
                        .padding(.leading, 5)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                        VStack {
                            SecureField("Password", text: $registerVM.userDetails.password)
                                .padding(.leading)
                        }
                    }
                    .frame(width: geo.frame(in: .local).size.width * 0.8, height: 45)
                }
                
                Spacer().frame(height: geo.size.height * 0.15)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Confirm Password")
                        .font(.title.bold())
                        .padding(.leading, 5)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                        VStack {
                            SecureField("Confirm Password", text: $registerVM.userDetails.confirmPassword)
                                .padding(.leading)
                        }
                    }
                    .frame(width: geo.frame(in: .local).size.width * 0.8, height: 45)
                }
            }
            .padding(.horizontal, 40)
        }
    }
    
}
