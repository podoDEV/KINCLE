//
//  FavoriteGym.swift
//  KINCLE
//
//  Created by Zedd on 2020/04/04.
//  Copyright © 2020 Zedd. All rights reserved.
//

import Foundation

class Gym: Decodable {
    
    var name: String = "홍대 더클라임"
    var address: String = "서울특별시 마포구 서교동 353 어쩌고 저쩌고"
    var mainImageURL: String?
    var isFavorite: Bool = true
    
    enum CodingKeys: String, CodingKey {
        
        case name
        case address
        case desc = "description"
        case mainImageURL = "imageUrl"
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.address = try container.decode(String.self, forKey: .address)
        self.mainImageURL = try container.decode(String.self, forKey: .mainImageURL)
    }
}
