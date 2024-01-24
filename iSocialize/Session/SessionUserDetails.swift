//
//  SessionUserDetails.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import SwiftUI

struct SessionUserDetails: Identifiable, Hashable {
    var id: String
    var fullName: String
    var email: String
    var nickname: String?
    var completeTagName: String?
    var picture: UIImage?
    var profilePicture: String?
}
