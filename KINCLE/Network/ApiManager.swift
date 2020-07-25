
import Combine
import UIKit

enum OAuthType {
    
    case email
    case apple
}

class ApiManager {
        
    static var shared: ApiManager = ApiManager()
    
    let apiHost = "http://13.125.45.92:8080"
    
    func login(email: String, password: String, type: OAuthType) {
       // let url =
    }
    
//    @Published var favoriteGyms: [Gym] = []
//
//    func requestFavoriteGyms() -> AnyPublisher<[Gym], Never>? {
//        let urlString = "\(self.apiHost)/v1/member/favorite"
//        let url = URL(string: urlString)!
//
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: Response<[Gym]>.self, decoder: JSONDecoder())
//            .map(\.data)
//            .replaceError(with: [])
//            .eraseToAnyPublisher()
//    }
}
