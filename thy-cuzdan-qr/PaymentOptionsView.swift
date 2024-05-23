import SwiftUI

struct PaymentOptionsView: View {
    @Binding var balance: Double
    @Binding var transactions: [Double]
    var itemPrice: Double

    @State private var showAlert = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Ödeme Seçenekleri")
                .font(.headline)
                .padding()

            HStack {
                VStack {
                    Image(systemName: "qrcode")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("QR Kod Oluştur")
                }
                .onTapGesture {
                    processPayment()
                }
                Spacer()
                VStack {
                    Image(systemName: "wave.3.left.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("NFC ile Öde")
                }
                .onTapGesture {
                    processPayment()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
        .overlay(
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .padding()
                            .background(Color.gray.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
        )
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Yetersiz Bakiye"), message: Text("Bakiyeniz bu ödemeyi gerçekleştirmek için yetersiz."), dismissButton: .default(Text("Tamam")))
        }
    }

    private func processPayment() {
        if balance >= itemPrice {
            balance -= itemPrice
            transactions.append(-itemPrice)
            print("Ödeme başarılı: \(itemPrice) TRY")
            presentationMode.wrappedValue.dismiss()
        } else {
            showAlert = true
            print("Yetersiz bakiye")
        }
    }
}

struct PaymentOptionsView_Previews: PreviewProvider {
    @State static var balance = 100.0
    @State static var transactions = [Double]()

    static var previews: some View {
        PaymentOptionsView(balance: $balance, transactions: $transactions, itemPrice: 10.0)
    }
}
