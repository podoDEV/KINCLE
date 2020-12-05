
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
            .tryMap { result -> RawResponse<T> in
                print(String(data: result.data, encoding: .utf8))
                let value = try self.decoder.decode(RawResponse<T>.self, from: result.data)
                return value
            }
            .replaceError(with: RawResponse<T>())
            .eraseToAnyPublisher()
    }
    
    func uploadProfileImage(with image: UIImage, completion: @escaping (ImageResponse) -> Void)  {
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        let uploadable = UploadableImageData(data: data, mimeType: "jpg")
        let url = "\(Key.apiHost)/upload"
        self.upload(url: url, uploadable: uploadable, completion: completion)
    }
    
    func upload<T: Decodable>(url: String, uploadable: Uploadable, headers: HTTPHeaders? = nil, completion: @escaping (T) -> Void) {
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
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(RawResponse<T>.self, from: data)
                    completion(object.data!)
                } catch {
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension ApiManager {
    
    func createMember(info: User) -> Response<User>? {
        let url = URL(string: "\(Key.apiHost)/v1/members")!
        let parameters: [String: Any] = [
            "emailAddress": info.email,
            "gymIds": info.gymIds,
            "level": info.level,
            "nickname": info.nickname,
            "password": info.password,
            "profileImageUrl": info.profileImageUrl,
            "oauthType": info.oauthType.stringForServer
        ]
        return self.post(url: url, parameters: parameters)
    }
    
    func getUser() -> Response<User> {
        let url = URL(string: "\(Key.apiHost)/v1/members/me")!
        let parameters: [String: Any] = [:]
        print("zedd")
        return self.get(url: url, parameters: parameters)
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

// 즐겨찾는 암장 등록
extension ApiManager {
    
    func registerMyFavoriteGyms(gym: SearchResultGym) -> Response<Gym>? {
        let url = URL(string: "\(Key.apiHost)/v1/gyms")!
        let parameters: [String: Any] = [
            "address": gym.address,
            "name": gym.name
        ]
        return self.post(url: url, parameters: parameters)
    }
}

// 즐겨찾는 암장 검색
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
            .map(\.data)
            .decode(type: GymDocument.self, decoder: self.decoder)
            .print()
            .replaceError(with: GymDocument())
            .eraseToAnyPublisher()
    }
}
