//
//  TextFieldViewCompo.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 19/01/2024.
//

import SwiftUI

struct TextFieldViewCompo: View {
    
    @Binding var stateProperty: String
    let textFieldTitle: String
    let textFieldPlaceholder: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(textFieldTitle)
                .font(.title2)
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(.black, lineWidth: 2)
                VStack {
                    TextField(textFieldPlaceholder ?? "", text: $stateProperty)
                        .submitLabel(.next)
                        .padding(.horizontal, 10)
                }
            }
            .frame(minHeight: 35, maxHeight: 55)
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    TextFieldViewCompo(stateProperty: .constant("Email"), textFieldTitle: "Email", textFieldPlaceholder: "Email")
}
