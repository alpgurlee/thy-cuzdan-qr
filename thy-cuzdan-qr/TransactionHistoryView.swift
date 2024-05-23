import SwiftUI

struct TransactionHistoryView: View {
    @Binding var transactions: [Double]

    var body: some View {
        VStack {
            Text("Hesap Hareketleri")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
                .padding()

            List(transactions, id: \.self) { transaction in
                HStack {
                    Text("TRY \(transaction, specifier: "%.2f")")
                    Spacer()
                    Text(Date(), style: .date)
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                .padding(.vertical, 10)
            }
        }
        .navigationTitle("Hesap Hareketleri")
        .background(Color.white.ignoresSafeArea())
    }
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView(transactions: .constant([500, 1000, 1500]))
    }
}
