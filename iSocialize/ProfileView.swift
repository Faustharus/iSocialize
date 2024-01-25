//
//  ProfileView.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 22/01/2024.
//

import FirebaseAuth
import PhotosUI
import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    @State private var isAboutToLogout: Bool = false
    
    @State private var animationsStatus: Bool = false
    @State private var animationsNickname: Bool = false
    @State private var animationsPwd: Bool = false
    @State private var animationsDelete: Bool = false
    @State private var animationsLogout: Bool = false
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    PhotosPicker(selection: $pickerItem, matching: .images) {
                        if selectedImage != nil {
                            selectedImage?
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
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
                    }
                    Button {
                        sessionService.updateProfilePicture(with: Auth.auth().currentUser!.uid, with: sessionService.userDetails)
                    } label: {
                        Text("Confirm Picture")
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
                
                ChevronActionButtonCompo(animated: $animationsStatus, buttonTitle: "Switch Status", buttonSubtitle: "Why hinding ?", sfSymbols: "person.badge.clock.fill", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    animationButton(_animationsStatus)
                    // TODO: Changing Online Status
                }
                .disabled(true)
                
                ChevronActionButtonCompo(animated: $animationsNickname, buttonTitle: "Add Nickname", buttonSubtitle: "There you go !", sfSymbols: "text.alignleft", buttonColor: .cyan, buttonWidth: 330, buttonHeight: 65) {
                    animationButton(_animationsNickname)
                    // TODO: Add Nickname/Pseudo
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
        .onChange(of: pickerItem) {
            Task {
                if let loaded = try? await pickerItem?.loadTransferable(type: Image.self) {
                    selectedImage = loaded
                }
            }
        }
    }
}

//#Preview {
//    NavigationStack {
//        ProfileView()
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
    
}
