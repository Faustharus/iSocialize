//
//  LoginView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 02/01/2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginVM = LoginViewModelImpl(service: LoginServiceImpl())
    
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
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email")
                        .font(.title2)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(.black, lineWidth: 2)
                        VStack {
                            TextField("Email", text: $loginVM.credentials.email)
                                .submitLabel(.next)
                                .padding(.horizontal, 5)
                        }
                    }
                    .frame(minHeight: 35, maxHeight: 55)
                }
                .padding(.horizontal, 15)
                
                Spacer().frame(minHeight: 16, maxHeight: 32)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Password")
                        .font(.title2)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(.black, lineWidth: 2)
                        VStack {
                            SecureField("********", text: $loginVM.credentials.password)
                                .submitLabel(.done)
                                .padding(.horizontal, 5)
                        }
                    }
                    .frame(minHeight: 35, maxHeight: 55)
                }
                .padding(.horizontal, 15)
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
        LoginView(switchPage: .constant(false))
    }
}

