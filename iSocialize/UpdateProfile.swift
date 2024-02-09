//
//  UpdateProfile.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 28/01/2024.
//

import FirebaseAuth
import PhotosUI
import SwiftUI

struct UpdateProfile: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    @Environment(\.dismiss) var dismiss
    
    @State private var pickerItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            if let pict = sessionService.userDetails.picture,
               let uiImage = UIImage(data: pict) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 300, maxHeight: 200)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1.5)
                    VStack {
                        PhotosPicker(selection: $pickerItem, matching: .images) {
                            ContentUnavailableView("Add Picture", systemImage: "photo.badge.plus")
                        }
                    }
                }
                .frame(maxWidth: 300, maxHeight: 200)
                .clipShape(.rect(cornerRadius: 10))
                .padding()
            }
            
//            Spacer()
            
            HStack {
                //if sessionService.userDetails.picture != nil || pickerItem != nil {
                    Button {
                        sessionService.updateProfilePicture(with: Auth.auth().currentUser!.uid, with: sessionService.userDetails)
                    } label: {
                        Label("Confirm Picture", systemImage: "checkmark")
                            .foregroundStyle(.white)
                    }
                    .tint(.green)
                    .buttonStyle(.borderedProminent)
                    .disabled(sessionService.userDetails.picture == nil || pickerItem == nil)
                    
                    Button(role: .destructive) {
                        withAnimation {
                            sessionService.userDetails.picture = nil
                            pickerItem = nil
                        }
                    } label: {
                        Label("Remove Picture", systemImage: "xmark")
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(sessionService.userDetails.picture == nil || pickerItem == nil)
                //}
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Full Name")
                    .font(.title)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1.5)
                    VStack {
                        TextField("Full Name", text: $sessionService.userDetails.fullname.toUnwrapped(defaultValue: ""))
                            .padding(.horizontal, 10)
                            .keyboardType(.default)
                            .autocorrectionDisabled()
                    }
                }
                .frame(width: 300, height: 55)
                
                
                Button {
                    // TODO: Add Full Name into Profile
                } label: {
                    Text("Confirm Name")
                }
                .disabled(sessionService.userDetails.fullname?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty != nil)
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 0)
                .padding(.vertical, 20)
            }
            .padding(.vertical, 20)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Label("Exit", systemImage: "rectangle.portrait.and.arrow.forward")
                    .foregroundStyle(.red)
            }
            .buttonStyle(.bordered)
        }
        .interactiveDismissDisabled(true)
//        .onAppear {
//            sessionService.handleRefresh(with: Auth.auth().currentUser!.uid)
//        }
        .task(id: pickerItem) {
            if let data = try? await pickerItem?.loadTransferable(type: Data.self) {
                sessionService.userDetails.picture = data
            }
        }
    }
}

#Preview {
    UpdateProfile()
        .environmentObject(SessionServiceImpl())
}
