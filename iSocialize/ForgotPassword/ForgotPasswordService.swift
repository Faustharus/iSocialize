//
//  ForgotPasswordService.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 20/01/2024.
//

import Combine
import FirebaseAuth
import Foundation

protocol ForgotPasswordService {
    func sendPasswordReset(to email: String) -> AnyPublisher<Void, Error>
}

final class ForgotPasswordServiceImpl: ForgotPasswordService {
    func sendPasswordReset(to email: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth
                    .auth()
                    .sendPasswordReset(withEmail: email) { error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
}
