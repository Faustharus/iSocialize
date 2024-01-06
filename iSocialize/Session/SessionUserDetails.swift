//
//  SessionUserDetails.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import Foundation

struct SessionUserDetails: Identifiable, Hashable {
    var id: String
    var fullName: String
    var email: String
}
