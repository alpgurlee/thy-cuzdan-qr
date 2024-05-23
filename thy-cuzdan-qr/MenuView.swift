import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let name: String
    let cashPrice: Double
    let cardPrice: Double
    let walletPrice: Double
    let imageName: String
}

struct MenuView: View {
    @State private var selectedItemPrice: Double = 0.0
    @State private var isShowingPaymentOptions = false
    @Binding var balance: Double
    @Binding var transactions: [Double]

    let drinks = [
        MenuItem(name: "Sprite", cashPrice: 15.5, cardPrice: 12.5, walletPrice: 9.5, imageName: "sprite"),
        MenuItem(name: "Fanta", cashPrice: 10.0, cardPrice: 9.0, walletPrice: 8.0, imageName: "fanta"),
        MenuItem(name: "Coca Cola", cashPrice: 20.0, cardPrice: 18.0, walletPrice: 15.5, imageName: "cocacola")
    ]

    let foods = [
        MenuItem(name: "Sandviç", cashPrice: 20.0, cardPrice: 18.0, walletPrice: 16.0, imageName: "sandwich"),
        MenuItem(name: "Tost", cashPrice: 15.0, cardPrice: 13.0, walletPrice: 11.0, imageName: "toast")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Menü")
                    .font(.largeTitle)
                    .padding()

                // İçecekler
                Text("İçecekler")
                    .font(.title)
                    .padding(.horizontal)

                ForEach(drinks) { drink in
                    HStack {
                        Image(drink.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 10)
                        VStack(alignment: .leading) {
                            Text(drink.name)
                                .font(.headline)
                            HStack {
                                Text("Nakit: TRY \(drink.cashPrice, specifier: "%.2f")")
                                Spacer()
                                Text("Kart: TRY \(drink.cardPrice, specifier: "%.2f")")
                                Spacer()
                                Text("Cüzdan: TRY \(drink.walletPrice, specifier: "%.2f")")
                            }
                            .font(.subheadline)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .onTapGesture {
                        selectedItemPrice = drink.walletPrice
                        isShowingPaymentOptions = true
                    }
                }

                // Yiyecekler
                Text("Yiyecekler")
                    .font(.title)
                    .padding(.horizontal)

                ForEach(foods) { food in
                    HStack {
                        Image(food.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 10)
                        VStack(alignment: .leading) {
                            Text(food.name)
                                .font(.headline)
                            HStack {
                                Text("Nakit: TRY \(food.cashPrice, specifier: "%.2f")")
                                Spacer()
                                Text("Kart: TRY \(food.cardPrice, specifier: "%.2f")")
                                Spacer()
                                Text("Cüzdan: TRY \(food.walletPrice, specifier: "%.2f")")
                            }
                            .font(.subheadline)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .onTapGesture {
                        selectedItemPrice = food.walletPrice
                        isShowingPaymentOptions = true
                    }
                }
            }
        }
        .navigationTitle("Menü")
        .sheet(isPresented: $isShowingPaymentOptions) {
            PaymentOptionsView(balance: $balance, transactions: $transactions, itemPrice: selectedItemPrice)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    @State static var balance = 100.0
    @State static var transactions = [Double]()

    static var previews: some View {
        MenuView(balance: $balance, transactions: $transactions)
    }
}
