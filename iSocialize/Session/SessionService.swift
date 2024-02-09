//
//  SessionService.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import Combine
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

enum SessionState {
    case loggedIn
    case loggedOut
}

protocol SessionService {
    var userDetails: SessionUserDetails { get }
    var state: SessionState { get }
    func logout()
}

final class SessionServiceImpl: ObservableObject, SessionService {
    
    @Published var userDetails: SessionUserDetails = .init(id: "", nickname: "", email: "", completeTagName: "", fullname: "")
    @Published var state: SessionState = .loggedOut
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    private var cancellables = Set<AnyCancellable>()
    
    let db = Firestore.firestore()
    
    init() {
        setupFirebaseAuthHandler()
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
    func updateProfilePicture(with uid: String, with details: SessionUserDetails) {
        guard let imageSelected = details.picture else {
            return
        }
        
        let storageRef = Storage.storage().reference(forURL: "STORAGE_LINK_HERE")
        let storageProfileRef = storageRef.child("profile").child("\(uid)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageProfileRef.putData(imageSelected, metadata: metadata, completion: {
            (storageMetadata, error) in
            if error != nil {
                print("\(String(describing: error?.localizedDescription))")
                return
            }
            
            storageProfileRef.downloadURL { [weak self] (url, error) in
                if let metaImageURL = url?.absoluteString {
                    self!.userDetails.profilePicture = metaImageURL
                    let profileRef = self!.db.collection("users").document("\(uid)")
                    profileRef.updateData([
                        "profilePicture": metaImageURL
                    ]) { error in
                        if let error = error {
                            print("Error updating profile picture: \(error.localizedDescription)")
                        } else {
                            print("Picture successfully updated")
                        }
                    }
                }
            }
        })
    }
    
    func deleteAccount(with uid: String, and password: String) {
        guard let user = Auth.auth().currentUser else { return }
        let credential = EmailAuthProvider.credential(withEmail: user.email!, password: password)
        
        let dbRef = db.collection("users").document(uid)
        let profilePictureRef = Storage.storage().reference().child("profile").child("\(uid)")
        dbRef.getDocument { (snapshot, error) in
            if snapshot != nil {
                Task {
                    do {
                        try await profilePictureRef.delete()
                        try await self.db.collection("users").document(uid).delete()
                        try await user.delete()
                    } catch {
                        print("Had not been able to delete the account")
                    }
                }
            }
        }
    }
    
}

extension SessionServiceImpl {
    
    func setupFirebaseAuthHandler() {
        handler = Auth
            .auth()
            .addStateDidChangeListener({ [weak self] res, user in
                guard let self = self else { return }
                self.state = user == nil ? .loggedOut : .loggedIn
                if let uid = user?.uid {
                    handleRefresh(with: uid)
                }
            })
    }
    
    func handleRefresh(with uid: String) {
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("Error Detected :", error?.localizedDescription ?? "Unknown Error")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    self.userDetails.id = data["id"] as? String ?? "N/A"
                    self.userDetails.nickname = data["nickname"] as? String ?? "N/A"
                    self.userDetails.email = data["email"] as? String ?? "N/A"
                    self.userDetails.completeTagName = data["completeTagName"] as? String ?? ""
                    self.userDetails.fullname = data["fullName"] as? String ?? ""
                    self.userDetails.profilePicture = data["profilePicture"] as? String ?? ""
                }
            }
            
            DispatchQueue.main.async {
                self.userDetails = SessionUserDetails(id: self.userDetails.id, nickname: self.userDetails.nickname, email: self.userDetails.email, completeTagName: self.userDetails.completeTagName, fullname: self.userDetails.fullname ?? "", profilePicture: self.userDetails.profilePicture ?? "")
            }
        }
    }
    
}
