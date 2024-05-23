import SwiftUI

struct MainView: View {
    @State private var isShowingSignUp = false
    @State private var isShowingLogin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("giris1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    
                    
                    NavigationLink(destination: LoginView(), isActive: $isShowingLogin) {
                        Button(action: {
                            isShowingLogin = true
                        }) {
                            Text("Giriş yap")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    NavigationLink(destination: SignUpView(), isActive: $isShowingSignUp) {
                        Button(action: {
                            isShowingSignUp = true
                        }) {
                            Text("Üye ol")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }
}
