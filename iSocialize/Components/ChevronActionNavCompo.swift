//
//  ChevronActionNavCompo.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 28/01/2024.
//

import SwiftUI

struct ChevronActionNavCompo<Content>: View where Content : View {
    
    let content: () -> Content
    
    @Binding var animated: Bool
    
    let buttonTitle: String
    let buttonSubtitle: String
    let sfSymbols: String
    let buttonColor: Color
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    init(@ViewBuilder _ content: @escaping () -> Content, animated: Binding<Bool>, buttonTitle: String, buttonSubtitle: String, sfSymbols: String, buttonColor: Color, buttonWidth: CGFloat, buttonHeight: CGFloat) {
        self.content = content
        _animated = animated
        self.buttonTitle = buttonTitle
        self.buttonSubtitle = buttonSubtitle
        self.sfSymbols = sfSymbols
        self.buttonColor = buttonColor
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(buttonColor.gradient.opacity(0.99).shadow(animated ? .inner(color: .black, radius: 2, x: 2, y: 2) : .drop(color: buttonColor, radius: 2, x: 2, y: 2)))
            VStack {
                NavigationLink {
                   content()
                } label: {
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

//#Preview {
//    ChevronActionNavCompo<TalkView>(animated: .constant(false), buttonTitle: "Update Profile", buttonSubtitle: "If you want to change it", sfSymbols: "person.crop.circle", buttonColor: .blue, buttonWidth: 300, buttonHeight: 65) { TalkView() }
//}

extension ChevronActionNavCompo {
    
//    private func animationButton(_ boolean: Binding<Bool>) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
//            withAnimation {
//                boolean.wrappedValue = false
//            }
//        }
//        withAnimation {
//            boolean.wrappedValue = true
//        }
//    }

}
