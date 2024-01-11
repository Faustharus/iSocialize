//
//  LoginDetails.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 06/01/2024.
//

import Foundation

struct LoginDetails {
    var email: String
    var password: String
}

extension LoginDetails {
    
    static var new: LoginDetails {
        .init(email: "", password: "")
    }
    
}
