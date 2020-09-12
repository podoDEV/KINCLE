import Foundation

class GymDocument: Decodable {
    var gyms: [Gym] = []
    
    enum CodingKeys: String, CodingKey {
        case gyms = "documents"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gyms = try container.decode([Gym].self, forKey: .gyms)
    }
    
    init() {}
}

class Gym: Decodable {
    
    var id: String = ""
    var name: String = "홍대 더클라임"
    var address: String = "서울특별시 마포구 서교동 353 어쩌고 저쩌고"
        
    enum CodingKeys: String, CodingKey {
        case id
        case name = "place_name"
        case address = "address_name"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.address = try container.decode(String.self, forKey: .address)
    }
    
    init() {}
}
