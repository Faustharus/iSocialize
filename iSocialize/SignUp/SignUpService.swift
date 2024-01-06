//
//  SignUpService.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import Combine
import Foundation
import Firebase

enum SignUpKeys: String {
    case id
    case email
    case fullName
}

protocol SignUpService {
    func register(with details: SignUpDetails) -> AnyPublisher<Void, Error>
}

final class SignUpServiceImpl: SignUpService {
    
    func register(with details: SignUpDetails) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth.auth().createUser(withEmail: details.email, password: details.password) { res, error in
                    if let error = error {
                        promise(.failure(error))
                        return
                    } else {
                        if let uid = res?.user.uid {
                            let db = Firestore.firestore()
                            
                            db.collection("users").document(uid).setData([
                                SignUpKeys.id.rawValue: uid,
                                SignUpKeys.email.rawValue: details.email,
                                SignUpKeys.fullName.rawValue: details.fullName
                            ]) { error in
                                if let error = error {
                                    promise(.failure(error))
                                } else {
                                    promise(.success(()))
                                }
                            }
                        } else {
                            promise(.failure(NSError(domain: "Invalid User ID", code: 0, userInfo: nil)))
                        }
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
}
