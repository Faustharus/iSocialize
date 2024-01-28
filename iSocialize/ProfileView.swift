//
//  ProfileView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 22/01/2024.
//

import FirebaseAuth
import SwiftUI

enum CurrentPageActive: Identifiable {
    case updateProfile
    
    var id: Int {
        hashValue
    }
}

struct ProfileView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    @State private var isAboutToLogout: Bool = false
    
    @State private var animationsStatus: Bool = false
    @State private var animationsProfile: Bool = false
    @State private var animationsPwd: Bool = false
    @State private var animationsDelete: Bool = false
    @State private var animationsLogout: Bool = false
    
    @State private var activePage: CurrentPageActive?
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    AsyncImage(url: URL(string: "\(sessionService.userDetails.profilePicture ?? "")")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 100, maxHeight: 100)
                                .clipShape(Circle())
                        case .empty, .failure:
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 100)
                                .foregroundStyle(.cyan.gradient)
                                .fontWeight(.light)
                            
                        @unknown default:
                            fatalError()
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
                    Text(sessionService.userDetails.nickname)
                        .font(.system(size: 36, weight: .light, design: .rounded))
                    Text(sessionService.userDetails.completeTagName)
                        .foregroundStyle(.secondary)
                }
                .font(.headline)
            }
            .padding(.horizontal, 20)
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            VStack(spacing: 30) {
                
                ChevronActionButtonCompo(animated: $animationsStatus, buttonTitle: "Switch Status", buttonSubtitle: "Why hinding ?", sfSymbols: "person.badge.clock.fill", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    animationButton(_animationsStatus)
                    // TODO: Changing Online Status
                }
                .disabled(true)
                
                ChevronActionButtonCompo(animated: $animationsProfile, buttonTitle: "Update Profile", buttonSubtitle: "There you go !", sfSymbols: "person.text.rectangle", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    animationButton(_animationsProfile)
                    self.activePage = .updateProfile
                }
                
                ChevronActionButtonCompo(animated: $animationsPwd, buttonTitle: "New Password", buttonSubtitle: "Someone know ?", sfSymbols: "lock.shield.fill", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    animationButton(_animationsPwd)
                    // TODO: Change Password
                }
                .disabled(true)
                
                ChevronActionButtonCompo(animated: $animationsDelete, buttonTitle: "Delete Account", buttonSubtitle: "Why qutting ?", sfSymbols: "trash.fill", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    animationButton(_animationsDelete)
                    // TODO: Delete the Account
                }
                .disabled(true)
                
                ChevronActionButtonCompo(animated: $animationsLogout, buttonTitle: "Logging out", buttonSubtitle: "See ya later !", sfSymbols: "power.circle.fill", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    animationButton(_animationsLogout)
                    isAboutToLogout = true
                }
                
            }
            .padding()
            
            Spacer()
            
        }
        .fullScreenCover(item: $activePage) { item in
            switch item {
            case .updateProfile:
                UpdateProfile()
            }
        }
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
        .onChange(of: sessionService.userDetails.picture) { Task { loadPicture() } }
        .onAppear {
            sessionService.handleRefresh(with: Auth.auth().currentUser!.uid)
        }
    }
}

//#Preview {
//    NavigationStack {
//        ProfileView()
//            .environmentObject(SessionServiceImpl())
//    }
//}

// MARK: Functions
extension ProfileView {
    
    private func animationButton(_ boolean: State<Bool>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation {
                boolean.wrappedValue = false
            }
        }
        withAnimation {
            boolean.wrappedValue = true
        }
    }
    
    func loadPicture() {
        if let pict = sessionService.userDetails.picture,
           let uiImage = UIImage(data: pict) {
            var _ = Image(uiImage: uiImage)
        }
    }
    
}
