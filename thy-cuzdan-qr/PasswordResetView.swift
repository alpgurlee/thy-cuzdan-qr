import SwiftUI
import CoreData

struct PasswordResetView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.email, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>

    @State private var email: String = ""
    @State private var newPassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Spacer()

            Text("Şifre Sıfırlama")
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

            SecureField("Yeni Şifre", text: $newPassword)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)

            Button(action: {
                resetPassword()
            }) {
                Text("Şifreyi Sıfırla")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)

            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Bilgi"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    private func resetPassword() {
        if let user = users.first(where: { $0.email == email }) {
            user.password = newPassword
            do {
                try viewContext.save()
                alertMessage = "Şifre başarıyla sıfırlandı."
            } catch {
                alertMessage = "Şifre sıfırlama başarısız oldu. Lütfen tekrar deneyin."
            }
        } else {
            alertMessage = "Bu e-posta adresiyle kayıtlı kullanıcı bulunamadı."
        }
        showAlert = true
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
