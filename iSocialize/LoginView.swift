//
//  LoginView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 02/01/2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                
                emailAndPassword
                
                Spacer().frame(height: geo.size.height * 0.1)
                
                Button {
                    // TODO: <# Tap Instruction Here #>
                } label: {
                    Text("Forgot Password ?")
                }
                .offset(x: 85, y: 0.0)
                .buttonStyle(.plain)
                .foregroundStyle(.secondary)
                
                Spacer().frame(height: 50)
                
                ZStack {
                    Capsule()
                        .fill(.cyan)
                    VStack {
                        Button {
                            // TODO: <# Tap Instruction Here #>
                        } label: {
                            Text("Log In")
                                .font(.system(size: 30, weight: .light, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.1)
                .padding(.horizontal, 30)
                
                Spacer().frame(height: 30)
                
                HStack(spacing: 0) {
                    Text("Don't have an account yet ? - ")
                    
                    Button {
                        switchPage.toggle()
                    } label: {
                        Text("Join")
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
        LoginView(switchPage: .constant(false))
    }
}

extension LoginView {
    
    private var emailAndPassword: some View {
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
                            TextField("Email", text: $email)
                                .padding(.leading)
                        }
                    }
                    .frame(width: geo.frame(in: .local).size.width * 0.8, height: 45)
                }
                
                Spacer().frame(height: geo.size.height * 0.15)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Password")
                        .font(.title.bold())
                        .padding(.leading, 5)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                        VStack {
                            TextField("Password", text: $password)
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
