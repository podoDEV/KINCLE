
import Combine
import UIKit
import Alamofire

protocol Uploadable {
    
    var mimeType: String { get set }
    var fileName: String { get }
    var data: Data { get set }
    var fileTypeName: String { get }
}

struct UploadableImageData: Uploadable {
    
    var data: Data
    var mimeType: String
    
    var fileTypeName: String {
        return "image"
    }
    
    var fileName: String {
        let type = self.mimeType.contains("gif") ? "gif" : "jpg"
        return String(format: "image_%.f.\(type)", Date.timeIntervalSinceReferenceDate)
    }
    
    init(data: Data, mimeType: String) {
        self.data = data
        self.mimeType = mimeType
    }
}

class ApiManager {
    
    static var shared: ApiManager = ApiManager()
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    typealias Response<T: Decodable> = AnyPublisher<RawResponse<T>, Never>
    
    func get<T: Decodable>(url: URL, parameters: [String: Any]?) -> Response<T> {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: RawResponse<T>.self, decoder: self.decoder)
            .replaceError(with: RawResponse<T>())
            .eraseToAnyPublisher()
    }
    
    func post<T: Decodable>(url: URL, parameters: [String: Any]?) -> Response<T>? {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: RawResponse<T>.self, decoder: self.decoder)
            .replaceError(with: RawResponse<T>())
            .eraseToAnyPublisher()
    }
    
    func upload(url: String, uploadable: Uploadable, headers: HTTPHeaders? = nil) {
        let method: HTTPMethod = HTTPMethod.post
        print(url)
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(
                uploadable.data,
                withName: uploadable.fileTypeName,
                fileName: uploadable.fileName,
                mimeType: uploadable.mimeType
            )
        }, to: url, usingThreshold: UInt64(), method: method, headers: nil, interceptor: .none).responseData { (response) in
            switch response.result {
            case let .success(data):
                print(String(data: data, encoding: .utf8))
            case let .failure(error):
                print(error)
            }
        }
    }
}

// MARK: 로그인
extension ApiManager {
    
    func login(email: String, password: String, type: OAuthType) -> Response<LoginResponse>? {
        let url = URL(string: "\(Key.apiHost)/v1/signin")!
        let parameters: [String: Any] = [
            "emailAddress": email,
            "password": password,
            "oauthType": type.stringForServer
        ]
        return self.post(url: url, parameters: parameters)
    }
}

// 즐겨찾는 암장
extension ApiManager {
    
    func searchGym(query: String) -> AnyPublisher<GymDocument, Never> {
        let url = URL(string: "https://dapi.kakao.com/v2/local/search/keyword.json")!
        var component = URLComponents(string: url.absoluteString)!
        component.queryItems = [URLQueryItem(name: "query", value: query)]
        var request = URLRequest(url: component.url ?? url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("KakaoAK \(Key.kakaoApiKey)", forHTTPHeaderField: "Authorization")
        return URLSession.shared.dataTaskPublisher(for: request)
            .print()
            .map(\.data)
            .decode(type: GymDocument.self, decoder: self.decoder)
            .print()
            .replaceError(with: GymDocument())
            .eraseToAnyPublisher()
    }
}
