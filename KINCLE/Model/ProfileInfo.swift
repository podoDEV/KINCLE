//
//  ProfileInfo.swift
//  KINCLE
//
//  Created by Zedd on 2020/09/12.
//  Copyright © 2020 Zedd. All rights reserved.
//

import Foundation

class ProfileInfo: Decodable {
    
    var email: String
    var password: String
    var imageURL: String?
    var lavel: Int = 0
    var oauthType: OAuthType = .email
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
