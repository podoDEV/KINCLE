
import Foundation

class Response<T: Decodable>: Decodable {
    
    var code: Int
    var data: T
    
    enum CodingKeys: String, CodingKey {
        
        case code
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(Int.self, forKey: .code)
        self.data = try container.decode(T.self, forKey: .data)
    }
}
