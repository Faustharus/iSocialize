//
//  ProfileView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 22/01/2024.
//

import FirebaseAuth
import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    var body: some View {
        VStack {
            Text("Welcome to iSocialize")
                .font(.title)
            
            Spacer().frame(height: 50)
            
            Text("\(sessionService.userDetails.fullName)'s Profile")
                .font(.headline)
            
            Button("Logout", role: .destructive) {
                sessionService.logout()
            }
            .buttonStyle(.borderedProminent)
            
        }
        .onAppear {
            sessionService.handleRefresh(with: Auth.auth().currentUser!.uid)
        }
    }
}

//#Preview {
//    ProfileView()
//}
