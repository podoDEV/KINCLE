import SwiftUI
import AuthenticationServices

struct GreetingView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("클라이밍을 즐기러 온 그대,")
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Text("반갑습니다!")
                .font(.system(size: 48))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
        }
        .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: 0, alignment: .leading)
        .padding(EdgeInsets(top: 0, leading: 23, bottom: 0, trailing: 23))
    }
}

struct IDInputView: View {
    
    @State private var ID: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .frame(width: 30.0, height: 30.0, alignment: .center)
                TextField("안녕", text: $ID)
            }
            .padding(EdgeInsets(top: 0, leading: 23, bottom: 0, trailing: 23))
        }
    }
}

struct LoginView: View {
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                GreetingView()
                .padding(.bottom, 78)
                IDInputView()
                SignInWithAppleButtonView()
                    .frame(width: 280, height: 60, alignment: .center)
                    .onTapGesture { self.showAppleLogin()
                }
            }
        }
    }
    
    private func showAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.performRequests()
    }
}

struct SignInWithAppleButtonView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        return ASAuthorizationAppleIDButton(type: .default,
                                            style: context.environment.colorScheme == .dark ? .white : .black)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
        LoginView().colorScheme(.dark) .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            LoginView().colorScheme(.dark) .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
            
        }
    }
}
