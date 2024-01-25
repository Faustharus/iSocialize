//
//  ChevronActionButtonCompo.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 23/01/2024.
//

import SwiftUI

struct ChevronActionButtonCompo: View {
    
    typealias ActionHandler = () -> Void
    
    @Binding var animated: Bool
    
    let buttonTitle: String
    let buttonSubtitle: String
    let sfSymbols: String
    let buttonColor: Color
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    let handler: ActionHandler
    
    init(animated: Binding<Bool>, buttonTitle: String, buttonSubtitle: String, sfSymbols: String, buttonColor: Color, buttonWidth: CGFloat, buttonHeight: CGFloat, handler: @escaping ChevronActionButtonCompo.ActionHandler) {
        _animated = animated
        self.buttonTitle = buttonTitle
        self.buttonSubtitle = buttonSubtitle
        self.sfSymbols = sfSymbols
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
                    HStack {
                        Image(systemName: sfSymbols)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .fontWeight(.ultraLight)
                        
                        Spacer()
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(.clear)
                            VStack(alignment: .leading) {
                                Text(buttonTitle)
                                    .bold()
                                Text(buttonSubtitle)
                                    .font(.subheadline)
                                    .foregroundStyle(.white.gradient)
                            }
                            .padding(.horizontal, 10)
                        }
                        
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                    }
                    .contentShape(Rectangle())
                    .padding(.horizontal, 30)
                }
                .buttonStyle(.plain)
                .foregroundStyle(.white)
            }
        }
        .frame(width: buttonWidth, height: buttonHeight)
        .shadow(color: .black, radius: 1, x: -0.5, y: -1)
    }
}

#Preview {
    ChevronActionButtonCompo(animated: .constant(false), buttonTitle: "Change Status", buttonSubtitle: "Why the hide, Jack ?", sfSymbols: "lock.fill", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) { }
}
