
import Foundation
import UIKit
import Combine

class LoginViewModel {
    
    var cancellable =  Set<AnyCancellable>()
    var registerGymSubject = PassthroughSubject<Void, Never>()
    var profileImageSubject = PassthroughSubject<String?, Never>()

    var gymsIds: [Int] = []
    var info: User = User()
    
    init(email: String, pw: String) {
        self.info.email = email
        self.info.password = pw
    }

    func createMember(gyms: [SearchResultGym], profileImage: UIImage?) {
        Publishers.Zip(self.registerGymSubject, self.profileImageSubject).sink { (_, url) in
            self.info.gymIds = self.gymsIds
            self.info.profileImageUrl = url
            ApiManager.shared.createMember(info: self.info)?.sink(receiveValue: { (response) in
                if let token = response.data?.token {
                    UserManager.shared.accessToken = token
                }
                UserManager.shared.accessToken = response.data?.token
                
                // 현재 화면 닫고
                // email, pw가지고 login api부르기
                // 
            }).store(in: &self.cancellable)
        }.store(in: &self.cancellable)
        self.registerGyms(gyms: gyms)
        self.uploadProfileImage(with: profileImage)
    }
    
    func registerGyms(gyms: [SearchResultGym]) {
        for index in 0..<gyms.count {
            ApiManager.shared.registerMyFavoriteGyms(gym: gyms[index])?.sink(receiveValue: { (gym) in
                self.gymsIds.append(gym.data?.gymId ?? 0)
                if index == gyms.count - 1 {
                    self.registerGymSubject.send(())
                }
            }).store(in: &self.cancellable)
        }
    }
    
    func uploadProfileImage(with image: UIImage?) {
        if let image = image {
            ApiManager.shared.uploadProfileImage(with: image) { (response) in
                self.profileImageSubject.send(response.imageUrl)
            }
        } else {
            self.profileImageSubject.send(nil)
        }
    }
}
