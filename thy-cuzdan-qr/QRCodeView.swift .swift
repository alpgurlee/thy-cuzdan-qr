import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State private var qrCodeText: String = UUID().uuidString

    var body: some View {
        VStack {
            if let qrImage = generateQRCode(from: qrCodeText) {
                Image(uiImage: qrImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            } else {
                Text("QR kod oluşturulamadı")
                    .foregroundColor(.red)
                    .padding()
            }
            Button("Yeni QR Kod Oluştur") {
                qrCodeText = UUID().uuidString
            }
            .padding()
        }
    }

    private func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return nil
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
    }
}
