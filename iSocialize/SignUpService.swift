//
//  SignUpService.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import Combine
import Foundation

final class SignUpServiceImpl {
    
    func register(with details: SignUpDetails) -> AnyPublisher<Void, Error> {
        
        Deferred {
            Future { promise in
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
}
