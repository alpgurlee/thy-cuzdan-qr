import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.email, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var isShowingSignUp = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("thy")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    Text("GİRİŞ YAP")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    TextField("E-posta adresi", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)

                    SecureField("Şifre", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)

                    Toggle(isOn: $rememberMe) {
                        Text("Beni hatırla")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)

                    Button(action: {
                        signIn()
                    }) {
                        Text("Giriş yap")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 10)

                    Text("Şifrenizi mi unuttunuz?")
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    Text("veya")
                        .foregroundColor(.white)
                        .padding(.bottom, 10)

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
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    private func signIn() {
        let user = users.first { $0.email == email && $0.password == password }
        if let user = user {
            print("Giriş başarılı: \(user.email ?? "")")
            // Giriş başarılı işlemleri burada yapılır
        } else {
            print("Giriş başarısız")
            // Giriş başarısız işlemleri burada yapılır
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
