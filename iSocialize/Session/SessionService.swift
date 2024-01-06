//
//  SessionService.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import Combine
import Foundation
import Firebase

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
    
    @Published var userDetails: SessionUserDetails = .init(id: "", fullName: "", email: "")
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
                    print("")
                    self.userDetails.id = data["id"] as? String ?? "N/A"
                    self.userDetails.fullName = data["fullName"] as? String ?? "N/A"
                    self.userDetails.email = data["email"] as? String ?? "N/A"
                }
            }
            
            DispatchQueue.main.async {
                self.userDetails = SessionUserDetails(id: self.userDetails.id, fullName: self.userDetails.fullName, email: self.userDetails.email)
            }
        }
    }
    
}
