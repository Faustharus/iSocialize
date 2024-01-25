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
    @State private var animationsPwd: Bool = false
    @State private var animationsBack: Bool = false
    
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
                    .keyboardType(.default)
                    .autocorrectionDisabled()
                    .submitLabel(.continue)
                
                Spacer().frame(minHeight: 16, maxHeight: 32)
                
                ActionButtonViewCompo(animated: $animationsPwd, buttonText: "Reset Password", buttonColor: .cyan, buttonWidth: geo.size.width * 0.8, buttonHeight: geo.size.height * 0.1) {
                    raiseAlert = true
                    animationButton(_animationsPwd)
//                    if checkEmailFormat(newValue: forgotPwdVM.email) {
//                        forgotPwdVM.sendPasswordReset()
//                    }
                }
                .shadow(color: .black, radius: 1, x: -0.5, y: -1)
//                .disabled(forgotPwdVM.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                Spacer().frame(minHeight: 16, maxHeight: 32)
                
                ActionButtonViewCompo(animated: $animationsBack, buttonText: "Back", buttonColor: .red, buttonWidth: geo.size.width * 0.8, buttonHeight: geo.size.height * 0.1) {
                    animationButton(_animationsBack)
                    dismiss()
                }
                .shadow(color: .black, radius: 1, x: -0.5, y: -1)
            }
            .alert(isPresented: $raiseAlert) {
                if checkEmailFormat(newValue: forgotPwdVM.email) {
                    return Alert(title: Text("Lost Password Request Sent"), message: Text("If you do have any account at \(forgotPwdVM.email), you should see the request in your MailBox - Check your Spam"), dismissButton: .default(Text("Resume")))
                } else {
                    return Alert(title: Text("Email Format Invalid"), message: Text("The format of your email is invalid"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}

// MARK: Functions
extension ForgotPasswordView {
    
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
    
    private func animationButton(_ boolean: State<Bool>) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation {
                    boolean.wrappedValue = false
                }
            }
            withAnimation {
                boolean.wrappedValue = true
            }
        }
    
}
