//
//  MainView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import FirebaseAuth
import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    var body: some View {
        TabView {
            TalkView()
                .tabItem {
                    Label("Discussions", systemImage: "captions.bubble")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .onAppear {
            sessionService.handleRefresh(with: Auth.auth().currentUser!.uid)
        }
    }
}

//#Preview {
//    MainView()
//        .environmentObject(SessionServiceImpl())
//}
