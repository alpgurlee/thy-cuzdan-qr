import SwiftUI

struct OfflinePaymentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showQRCode = false
    @State private var showNFC = false

    var body: some View {
        VStack {
            Text("Offline Ödeme Seçenekleri")
                .font(.headline)
                .padding()

            HStack {
                VStack {
                    Image(systemName: "qrcode")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("QR Kod ile Öde")
                }
                .onTapGesture {
                    showQRCode.toggle()
                }
                .sheet(isPresented: $showQRCode) {
                    QRCodeView()
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
                    showNFC.toggle()
                }
                .sheet(isPresented: $showNFC) {
                    Text("NFC ile ödeme için pos cihazına yaklaştırınız.")
                        .padding()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)

            Spacer()

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Geri Dön")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
    }
}

struct OfflinePaymentView_Previews: PreviewProvider {
    static var previews: some View {
        OfflinePaymentView()
    }
}
