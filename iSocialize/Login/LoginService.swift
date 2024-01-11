//
//  LoginService.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 06/01/2024.
//

import Combine
import Foundation
import FirebaseAuth

protocol LoginService {
    func login(with credentials: LoginDetails) -> AnyPublisher<Void, Error>
}

final class LoginServiceImpl: LoginService {
    
    func login(with credentials: LoginDetails) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth
                    .auth()
                    .signIn(withEmail: credentials.email, password: credentials.password) { res, error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
}
