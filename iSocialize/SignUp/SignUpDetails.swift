//
//  SignUpDetails.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import Foundation

struct SignUpDetails: Identifiable {
    var id: String = UUID().uuidString
    var nickname: String
    var email: String
    var password: String
    var confirmPassword: String
}

extension SignUpDetails {
    
    static var new: SignUpDetails {
        .init(nickname: "", email: "", password: "", confirmPassword: "")
    }
    
}
