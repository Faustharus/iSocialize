//
//  ActionButtonViewCompo.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 19/01/2024.
//

import SwiftUI

struct ActionButtonViewCompo: View {
    
    typealias ActionHandler = () -> Void
    
    let buttonText: String
    let buttonColor: Color
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    let handler: ActionHandler
    
    init(buttonText: String, buttonColor: Color, buttonWidth: CGFloat, buttonHeight: CGFloat, handler: @escaping ActionButtonViewCompo.ActionHandler) {
        self.buttonText = buttonText
        self.buttonColor = buttonColor
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        self.handler = handler
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(buttonColor)
            VStack {
                Button(action: handler) {
                    Text(buttonText)
                        .font(.system(size: 28, weight: .light, design: .default))
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(width: buttonWidth, height: buttonHeight)
    }
}

#Preview {
    ActionButtonViewCompo(buttonText: "LogIn", buttonColor: .blue, buttonWidth: 150, buttonHeight: 65) { }
}
