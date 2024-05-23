import SwiftUI
import CoreData

struct BalanceView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var selectedAmount: Double = 500
    @State private var balance: Double = 0

    var body: some View {
        VStack {
            HStack {
                Text("TK CÜZDAN")
                    .font(.largeTitle)
                    .padding()

                Spacer()
            }

            Spacer()

            Text("Toplam bakiye")
                .font(.headline)
                .padding(.top)

            Text("TRY \(balance, specifier: "%.2f")")
                .font(.title)
                .padding(.bottom, 20)

            Button(action: {
                // Hesap hareketleri işlemi
            }) {
                HStack {
                    Text("Hesap hareketleri")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            }

            Button(action: {
                // Kredi/banka kartı ekleme işlemi
            }) {
                HStack {
                    Text("Kredi/banka kartı ekle")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            }

            Text("TK Cüzdan'ınıza ne kadar para eklemek istersiniz?")
                .font(.subheadline)
                .padding(.top, 20)
                .padding(.horizontal)

            Picker("Select amount", selection: $selectedAmount) {
                Text("TRY 500,00").tag(500.0)
                Text("TRY 1.000,00").tag(1000.0)
                Text("TRY 1.500,00").tag(1500.0)
            }
            .pickerStyle(RadioGroupPickerStyle())
            .padding()

            Button(action: {
                addMoney()
            }) {
                Text("Para ekle")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            Spacer()
        }
        .onAppear {
            // Kullanıcı bilgilerini çekerek mevcut bakiye gibi bilgileri yükleme
            loadUserData()
        }
    }

    private func addMoney() {
        balance += selectedAmount
        // Core Data veya başka bir persistent storage kullanarak bakiye güncelleme işlemi yapılabilir
    }

    private func loadUserData() {
        // Mevcut kullanıcı verilerini yükleyerek mevcut bakiye gibi bilgileri ayarlama
        // Örneğin: balance = currentUser.balance
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
