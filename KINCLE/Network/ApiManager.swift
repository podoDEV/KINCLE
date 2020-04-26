
import Combine
import UIKit

class ApiManager {
    
    @Published var isSubmitAllowed: Bool = false
    weak var submitButton: UIButton!
    static var shared: ApiManager = ApiManager()
    let apiHost = "http://13.125.45.92:8080"
        @Published var favoriteGyms: [Gym] = []
    func requestFavoriteGyms() -> AnyPublisher<[Gym], Never>? {
        let urlString = "\(self.apiHost)/v1/member/favorite"
        let url = URL(string: urlString)!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Response<[Gym]>.self, decoder: JSONDecoder())
            .map(\.data)
            .replaceError(with: [])
            .eraseToAnyPublisher()
//
//
//
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
//
//        let dd = URLSession.shared.dataTaskPublisher(for: url)
//        .map { $0.data }
//        .decode(type: [Gym].self, decoder: JSONDecoder())
//        .replaceError(with: [])
//        .eraseToAnyPublisher()
//        .assign(to: \.favoriteGyms, on: self)

    }
}
