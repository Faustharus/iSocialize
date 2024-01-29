//
//  DeleteProfile.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 29/01/2024.
//

import FirebaseAuth
import SwiftUI

struct DeleteProfile: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    @Environment(\.dismiss) var dismiss
    
    @State private var confirmationPassword: String = ""
    
    var body: some View {
        VStack {
            Text("Are you sure ?")
                .font(.title)
            
            SecureField("Password", text: $confirmationPassword)
                .keyboardType(.default)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button(role: .destructive) {
                sessionService.deleteAccount(with: Auth.auth().currentUser!.uid, and: confirmationPassword)
                dismiss()
            } label: {
                Text("Delete")
            }
            .buttonStyle(.borderedProminent)
            .disabled(confirmationPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }
}

#Preview {
    DeleteProfile()
        .environmentObject(SessionServiceImpl())
}
