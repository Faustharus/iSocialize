//
//  ChevronActionButtonCompo.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 23/01/2024.
//

import SwiftUI

struct ChevronActionButtonCompo: View {
    
    typealias ActionHandler = () -> Void
    
    let buttonTitle: String
    let buttonSubtitle: String
    let sfSymbols: String
    let buttonColor: Color
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    let handler: ActionHandler
    
    init(buttonTitle: String, buttonSubtitle: String, sfSymbols: String, buttonColor: Color, buttonWidth: CGFloat, buttonHeight: CGFloat, handler: @escaping ChevronActionButtonCompo.ActionHandler) {
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
            Capsule()
                .stroke(.black, lineWidth: 1)
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
                    .padding(.horizontal, 30)
                }
                .buttonStyle(.plain)
                .foregroundStyle(.white)
            }
        }
        .background(buttonColor.gradient)
        .frame(width: buttonWidth, height: buttonHeight)
        .clipShape(Capsule())
        .shadow(color: .black, radius: 1, x: -0.5, y: -1)
    }
}

#Preview {
    ChevronActionButtonCompo(buttonTitle: "Change Status", buttonSubtitle: "Why the hide, Jack ?", sfSymbols: "lock", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) { }
}
