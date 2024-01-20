//
//  ForgotPasswordView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 20/01/2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var forgotPwdVM = ForgotPasswordViewModelImpl(service: ForgotPasswordServiceImpl())
    
    @State private var tapButton: Bool = false
    @State private var tapBackButton: Bool = false
    
    @State private var raiseAlert: Bool = false
    
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
                
                TextFieldViewCompo(stateProperty: $forgotPwdVM.email, textFieldTitle: "Email", textFieldPlaceholder: "Email")
                
                Spacer().frame(minHeight: 16, maxHeight: 32)
                
                ActionButtonViewCompo(buttonText: "Reset Password", buttonColor: .cyan, buttonWidth: geo.size.width * 0.8, buttonHeight: geo.size.height * 0.1) {
                    forgotPwdVM.sendPasswordReset()
                }
                .disabled(forgotPwdVM.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                Spacer().frame(minHeight: 16, maxHeight: 32)
                
                ActionButtonViewCompo(buttonText: "Back", buttonColor: .red, buttonWidth: geo.size.width * 0.8, buttonHeight: geo.size.height * 0.1) {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}
