 
import Combine
import Foundation
 
 class MyPageViewModel {
    
    var user: User = User()
    var userStream = PassthroughSubject<Void, Never>()
    var cancellable =  Set<AnyCancellable>()
    
    func getUser() {
        ApiManager.shared.getUser().sink { (response) in
            if let response = response.data {
                self.user = response
                self.userStream.send(())
            }
        }.store(in: &self.cancellable)
    }
    
    init() {
        self.getUser()
    }
 }
