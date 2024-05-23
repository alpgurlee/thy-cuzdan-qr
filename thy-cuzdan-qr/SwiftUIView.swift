import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.email, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Spacer()

            Text("GİRİŞ YAP")
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding(.bottom, 20)

            TextField("E-posta adresi", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)

            SecureField("Şifre", text: $password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)

            Toggle(isOn: $rememberMe) {
                Text("Beni hatırla")
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

            Button(action: {
                // Şifrenizi unuttunuz mu işlemi
            }) {
                Text("Şifrenizi mi unuttunuz?")
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)

            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Hata"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
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
            alertMessage = "Giriş başarılı!"
        } else {
            print("Giriş başarısız")
            alertMessage = "Giriş başarısız. Lütfen bilgilerinizi kontrol edin."
        }
        showAlert = true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
