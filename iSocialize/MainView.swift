//
//  MainView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import FirebaseAuth
import SwiftUI

enum PageSelected: String, Identifiable {
    case talk, profile
    
    var id: Int {
        hashValue
    }
}

struct MainView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    var body: some View {
        TabView {
            NavigationStack {
                TalkView()
            }
            .tabItem {
                Label("Discussions", systemImage: "captions.bubble")
            }
            .tag(PageSelected.talk)
            
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
            .tag(PageSelected.profile)
        }
    }
}

#Preview {
    MainView()
        .environmentObject(SessionServiceImpl())
}
