
import Combine
import UIKit

class ApiManager {
    
    static var shared: ApiManager = ApiManager()
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    typealias Response<T: Decodable> = AnyPublisher<RawResponse<T>, Never>
    
    func post<T: Decodable>(url: URL, parameters: [URLQueryItem]) -> Response<T>? {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody =  components?.percentEncodedQuery?.data(using: .utf8)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: RawResponse<T>.self, decoder: self.decoder)
            .print()
            .replaceError(with: RawResponse<T>())
            .eraseToAnyPublisher()
    }
}

// MARK: 로그인
extension ApiManager {
    
    func login(email: String, password: String, type: OAuthType) -> Response<LoginResponse>? {
        let url = URL(string: "\(Key.apiHost)/v1/signin")!
        let email = URLQueryItem(name: "emailAddress", value: email)
        let password = URLQueryItem(name: "password", value: password)
        let type = URLQueryItem(name: "oauthType", value: type.stringForServer)
        return self.post(url: url, parameters: [email, password, type])
    }
}
