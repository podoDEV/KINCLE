
import Combine
import UIKit

enum OAuthType {
    
    case email
    case apple
}

class LoginResponse: Decodable {
    
    var token: String = ""
}

class ApiManager {
    
    static var shared: ApiManager = ApiManager()
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    typealias Response<T: Decodable> = AnyPublisher<RawResponse<T>, Never>
    
    func login(email: String, password: String, type: OAuthType) -> Response<LoginResponse>? {
        let url = URL(string: "\(Key.apiHost)/v1/signin")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let email = URLQueryItem(name: "emailAddress", value: email)
        let password = URLQueryItem(name: "password", value: password)
        let type = URLQueryItem(name: "type", value: "self")

        components?.queryItems = [email, password, type]
        
        var request = URLRequest(url: components!.url ?? url)
        request.httpMethod = "POST"
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: RawResponse<LoginResponse>.self, decoder: self.decoder)
            .replaceError(with: RawResponse<LoginResponse>())
            .eraseToAnyPublisher()
    }
}
