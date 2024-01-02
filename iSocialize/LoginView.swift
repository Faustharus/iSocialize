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
    
    var body: some View {
        VStack {
            Image(systemName: "bubble.left.and.bubble.right")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            Text("Where socializing feels rewarding")
                .font(.system(size: 18, weight: .light, design: .rounded))
                .italic()
            
            Spacer().frame(height: 62)
            
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
                .frame(height: 45)
                .containerRelativeFrame(.horizontal) { width, size in
                    width * 0.8
                }
            }
            
            Spacer().frame(height: 36)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Password")
                    .font(.title.bold())
                    .padding(.leading, 5)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                    VStack {
                        SecureField("Password", text: $password)
                            .padding(.leading)
                    }
                }
                .frame(height: 45)
                .containerRelativeFrame(.horizontal) { width, size in
                    width * 0.8
                }
            }
            
            Spacer().frame(height: 12)
            
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
            .containerRelativeFrame(.vertical) { height, size in
                height * 0.1
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            HStack(spacing: 0) {
                Text("Don't have an account yet ? - ")
                
                Button {
                    // TODO: <# Tap Instruction Here #>
                } label: {
                    Text("Join")
                }
            }
            
        }
        .navigationTitle("iSocialize")
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
