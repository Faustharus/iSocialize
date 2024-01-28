//
//  SessionUserDetails.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import SwiftUI

struct SessionUserDetails: Identifiable, Hashable {
    var id: String
    var nickname: String
    var email: String
    var completeTagName: String
    var fullname: String?
    var picture: Data?
    var profilePicture: String?
}
