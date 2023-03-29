//
//  ContentView.swift
//  ConverterDevise
//
//  Created by Kamal KHATIM on 28/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = ""
    @State private var fromCurrency = "USD"
    @State private var toCurrency = "EUR"
    @State private var conversionRate = 0.0
    @State private var convertedAmount = 0.0
    
    let apiUrl = "https://api.exchangerate-api.com/v4/latest/"
    
    var body: some View {
        
        VStack{
            Image("cd")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150, alignment: .center)
                .clipped()
            
            NavigationView {
                Form {
                    Section(header: Text("Form")) {
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                        
                        Picker("Currency", selection: $fromCurrency){
                            Text("USD").tag("USD")
                            Text("MAD").tag("MAD")
                            Text("EUR").tag("EUR")
                            Text("GEP").tag("GEP")
                            Text("JPY").tag("JPY")
                        }
                        
                        .pickerStyle(.segmented)
                    }
                    
                    Section(header: Text("To")) {
                        Picker("Currency", selection: $toCurrency) {
                            Text("USD").tag("USD")
                            Text("MAD").tag("MAD")
                            Text("EUR").tag("EUR")
                            Text("GEP").tag("GEP")
                            Text("JPY").tag("JPY")
                        }
                        .pickerStyle(.segmented)
                        Text("\(convertedAmount, specifier: "%.2f")")
                    }
                }
                .navigationTitle("Converter :")
                .onAppear(perform: fetchConversionRate)
            }
        }
    }
    
    func fetchConversionRate() {
        let urlString = "\(apiUrl)\(fromCurrency)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try?
                    JSONDecoder().decode(ExchangeRateResponse.self, from: data) {
                    DispatchQueue.main.async {
                        conversionRate = decodedResponse.rates[toCurrency] ?? 0
                        if let amount = Double(amount) {
                            convertedAmount = amount * conversionRate
                        }
                    }
                    return
                }
            }
        }.resume()
    }
}

struct ExchangeRateResponse: Codable {
    let rates: [String: Double]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
