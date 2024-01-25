//
//  ActionButtonViewCompo.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 19/01/2024.
//

import SwiftUI

struct ActionButtonViewCompo: View {
    
    typealias ActionHandler = () -> Void
    
    @Binding var animated: Bool
    
    let buttonText: String
    let buttonColor: Color
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    let handler: ActionHandler
    
    init(animated: Binding<Bool>, buttonText: String, buttonColor: Color, buttonWidth: CGFloat, buttonHeight: CGFloat, handler: @escaping ActionButtonViewCompo.ActionHandler) {
        _animated = animated
        self.buttonText = buttonText
        self.buttonColor = buttonColor
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        self.handler = handler
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(buttonColor.gradient.opacity(0.99).shadow(animated ? .inner(color: .black, radius: 2, x: 2, y: 2) : .drop(color: buttonColor, radius: 2, x: 2, y: 2)))
            VStack {
                Button(action: handler) {
                    VStack {
                        Text(buttonText)
                            .font(.system(size: 28, weight: .light, design: .default))
                            .frame(width: buttonWidth, height: buttonHeight)
                            .foregroundStyle(.white)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .frame(width: buttonWidth, height: buttonHeight)
    }
}

#Preview {
    ActionButtonViewCompo(animated: .constant(false), buttonText: "LogIn", buttonColor: .cyan, buttonWidth: 300, buttonHeight: 65) { }
}
