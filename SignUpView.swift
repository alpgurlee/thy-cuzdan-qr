import SwiftUI

struct SignUpView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Spacer()

            Text("ÜYE OL")
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding(.bottom, 20)

            TextField("İsim", text: $firstName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)

            TextField("Soy İsim", text: $lastName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)

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

            Button(action: {
                addUser()
            }) {
                Text("Üye Ol")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)

            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    private func addUser() {
        withAnimation {
            let newUser = User(context: viewContext)
            newUser.firstName = firstName
            newUser.lastName = lastName
            newUser.email = email
            newUser.password = password
            newUser.rememberMe = false

            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss() // Kayıt başarılıysa ekrandan çıkış yap
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
