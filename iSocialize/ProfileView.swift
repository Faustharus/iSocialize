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
    
    @State private var isAboutToLogout: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Button {
                        // TODO: Change Profile Picture
                    } label: {
                        AsyncImage(url: URL(string: "\(sessionService.userDetails.profilePicture ?? "")")) { phase in
                            switch phase {
                            case .empty:
                                HStack {
                                    Spacer()
                                    ProgressView()
                                    Spacer()
                                }
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan.gradient)
                                    .fontWeight(.light)
                                
                            @unknown default:
                                fatalError()
                            }
                        }
                    }
                    HStack {
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.green)
                        Text("Online")
                            .font(.system(size: 18, weight: .light, design: .rounded))
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    if (sessionService.userDetails.nickname != "N/A") {
                        Text(sessionService.userDetails.nickname ?? "")
                            .font(.system(size: 36, weight: .light, design: .rounded))
                        Text("\(sessionService.userDetails.nickname ?? "")#\(Int.random(in: 0000 ..< 10000))")
                            .foregroundStyle(.secondary)
                    } else {
                        Text(sessionService.userDetails.fullName)
                            .font(.system(size: 26, weight: .light, design: .rounded))
                    }
                }
                .font(.headline)
            }
            .padding(.horizontal, 20)
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            VStack(spacing: 30) {
                
                ChevronActionButtonCompo(buttonTitle: "Switch Status", buttonSubtitle: "Why hinding ?", sfSymbols: "person.badge.clock.fill", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    // TODO: Changing Online Status
                }
                .disabled(true)
                
                ChevronActionButtonCompo(buttonTitle: "Add Nickname", buttonSubtitle: "There you go !", sfSymbols: "text.alignleft", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    // TODO: Add Nickname/Pseudo
                }
                
                ChevronActionButtonCompo(buttonTitle: "New Password", buttonSubtitle: "Someone know ?", sfSymbols: "lock.shield.fill", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    // TODO: Change Password
                }
                .disabled(true)
                
                ChevronActionButtonCompo(buttonTitle: "Delete Account", buttonSubtitle: "Why qutting ?", sfSymbols: "trash.fill", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    // TODO: Delete the Account
                }
                .disabled(true)
                
                ChevronActionButtonCompo(buttonTitle: "Logging out", buttonSubtitle: "See ya later !", sfSymbols: "power.circle.fill", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    isAboutToLogout = true
                }
                
            }
            .padding()
            
            Spacer()
            
        }
        .navigationTitle("😊 Hi there ! John Doe 👋")
        /* sessionService.userDetails.fullName */
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("You're leaving so soon ?", isPresented: $isAboutToLogout, titleVisibility: .visible, actions: {
            Button(role: .destructive) {
                sessionService.logout()
            } label: {
                Text("Logout")
                    .font(.headline)
            }
        }, message: {
            Text("Come back quickly !")
        })
        .onAppear {
            sessionService.handleRefresh(with: Auth.auth().currentUser!.uid)
        }
    }
}

//#Preview {
//    NavigationStack {
//        ProfileView()
//    }
//}
