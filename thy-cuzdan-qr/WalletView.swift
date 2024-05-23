import SwiftUI

struct WalletView: View {
    @State private var selectedAmount: Double = 0.0
    @State private var customAmount: String = ""
    @State private var balance: Double = 0.0
    @State private var transactions: [Double] = []
    @State private var isShowingTransactions = false
    @State private var isShowingMenu = false
    @State private var isShowingOfflinePayment = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // ZStack kullanarak resim ve yazıları üst üste yerleştiriyoruz
            ZStack {
                Image("balanceImage") // "balanceImage" adlı resmi projenize eklediğinizden emin olun
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200) // İstediğiniz yükseklik değerini burada belirleyin
                
                VStack {
                    Text("TK CÜZDAN")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.top, 50)
                    
                    Text("Toplam bakiye")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.top, 10)

                    Text("TRY \(balance, specifier: "%.2f")")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                }
            }
            .padding(.bottom, 20)

            NavigationLink(destination: TransactionHistoryView(transactions: $transactions), isActive: $isShowingTransactions) {
                Button(action: {
                    isShowingTransactions = true
                }) {
                    HStack {
                        Text("Hesap hareketleri")
                            .foregroundColor(.blue)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                }
            }

            NavigationLink(destination: MenuView(balance: $balance, transactions: $transactions), isActive: $isShowingMenu) {
                Button(action: {
                    isShowingMenu = true
                }) {
                    HStack {
                        Text("Menü")
                            .foregroundColor(.blue)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                }
            }

            NavigationLink(destination: OfflinePaymentView(), isActive: $isShowingOfflinePayment) {
                Button(action: {
                    isShowingOfflinePayment = true
                }) {
                    HStack {
                        Text("Offline Ödeme")
                            .foregroundColor(.blue)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                }
            }

            Text("TK Cüzdan'ınıza ne kadar para eklemek istersiniz?")
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 10) {
                RadioButton(title: "TRY 500,00", amount: 500.0, selectedAmount: $selectedAmount)
                RadioButton(title: "TRY 1.000,00", amount: 1000.0, selectedAmount: $selectedAmount)
                RadioButton(title: "TRY 1.500,00", amount: 1500.0, selectedAmount: $selectedAmount)

                HStack {
                    RadioButton(title: "Diğer", amount: 0.0, selectedAmount: $selectedAmount)
                    if selectedAmount == 0.0 {
                        TextField("Tutar", text: $customAmount)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            Spacer()

            Button(action: {
                if selectedAmount == 0.0, let amount = Double(customAmount) {
                    addMoney(amount: amount)
                } else {
                    addMoney(amount: selectedAmount)
                }
            }) {
                Text("Para ekle")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
        }
        .onAppear {
            updateBalance()
        }
        .background(Color.white.ignoresSafeArea())
    }

    private func addMoney(amount: Double) {
        transactions.append(amount)
        balance += amount
        updateBalance()
        print("Eklenen miktar: \(amount) TRY")
    }

    private func updateBalance() {
        balance = transactions.reduce(0, +)
    }
}

struct RadioButton: View {
    var title: String
    var amount: Double
    @Binding var selectedAmount: Double

    var body: some View {
        Button(action: {
            selectedAmount = amount
        }) {
            HStack {
                Image(systemName: selectedAmount == amount ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(selectedAmount == amount ? .blue : .gray)
                Text(title)
                    .foregroundColor(.black)
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
