//
//  SecureFieldViewCompo.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 19/01/2024.
//

import SwiftUI

struct SecureFieldViewCompo: View {
    
    @Binding var stateProperty: String
    @Binding var toSeePassword: Bool
    let secureFieldTitle: String
    let secureFieldPlaceholder: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(secureFieldTitle)
                .font(.title2)
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(.black, lineWidth: 2)
                HStack {
                    if toSeePassword {
                        TextField(secureFieldPlaceholder ?? "", text: $stateProperty)
                            .submitLabel(.next)
                            .padding(.horizontal, 10)
                    } else {
                        SecureField(secureFieldPlaceholder ?? "", text: $stateProperty)
                            .submitLabel(.next)
                            .padding(.horizontal, 10)
                    }
                    Button {
                        toSeePassword.toggle()
                    } label: {
                        Image(systemName: toSeePassword ? "eye.fill" : "eye.slash.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, 10)
                }
            }
            .frame(minHeight: 35, maxHeight: 55)
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    SecureFieldViewCompo(stateProperty: .constant("Password"), toSeePassword: .constant(false), secureFieldTitle: "Password", secureFieldPlaceholder: "Password")
}
