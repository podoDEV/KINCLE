//
//  File.swift
//  KINCLE
//
//  Created by Zedd on 2020/11/07.
//  Copyright © 2020 Zedd. All rights reserved.
//

import Foundation

class User: Decodable {
    
    var email: String = ""
    var gyms: [Gym] = []
    var gymIds: [Int] = []
    var level: Int = 1
    var nickname: String = ""
    var oauthType: OAuthType = .email
    var password: String = ""
    var profileImageUrl: String?
    var token: String?
    
    var likeCount: Int = 0
    var solveCount: Int = 0
    
    var memberId: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "emailAddress"
        case level
        case likeCount
        case nickname
        case profileImageUrl
        case solveCount
        case gyms
        case token = "accessToken"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gyms = (try? container.decode([Gym].self, forKey: .gyms)) ?? []
        self.email = (try? container.decode(String.self, forKey: .email)) ?? ""
        self.level = (try? container.decode(Int.self, forKey: .level)) ?? 0
        self.likeCount = (try? container.decode(Int.self, forKey: .likeCount)) ?? 0
        self.solveCount = (try? container.decode(Int.self, forKey: .solveCount)) ?? 0
        self.nickname = (try? container.decode(String.self, forKey: .nickname)) ?? ""
        self.profileImageUrl = (try? container.decode(String.self, forKey: .profileImageUrl)) ?? ""
        self.token = try? container.decode(String.self, forKey: .token)
    }
    
    init() {}
}
