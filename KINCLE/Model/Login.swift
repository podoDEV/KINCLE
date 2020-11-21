
import Combine
import UIKit

enum OAuthType: String, Decodable {

    case email
    case apple
    
    var stringForServer: String {
        switch self {
        case .email:
            return "self" // 이메일로 보낼때는 self. 다른때는 토큰 없어도 됨.
        case .apple:
            return "apple"
        }
    }
}

class LoginResponse: Decodable {
    
    var token: String = ""
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        
        case token
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = (try? container.decode(String.self, forKey: .token)) ?? ""
        self.message = try? container.decode(String.self, forKey: .message)
    }
}
