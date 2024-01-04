//
//  ContentView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 01/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var switchPage: Bool = false
    
    var body: some View {
        VStack {
            if switchPage {
                SignUpView(switchPage: $switchPage)
            } else {
                LoginView(switchPage: $switchPage)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
