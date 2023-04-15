//
//  ContentView.swift
//  CurrencyConverterSample
//
//  Created by Paulo Orquillo on 15/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var currencyVM = CurrencyVM()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Currency converter")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
            //create a text field for the amount
            TextField("Enter amount", value: $currencyVM.amount, formatter: NumberFormatter())
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200)
            
            
            HStack {
                //create a picker for all the currencie and default to the current currency
                Picker("Enter currency", selection: $currencyVM.currency) {
                    ForEach(currencyVM.currencies, id: \.self) { currency in
                        Text(currency)
                    }
                }
                //create a new picker for all the currencies
                Picker("Enter new currency", selection: $currencyVM.newCurrencyValue) {
                    ForEach(currencyVM.currencies, id: \.self) { currency in
                        Text(currency)
                    }
                }
            }
            
            Text("Amount \(currencyVM.convertedAmount)" )
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
            
            Button(action : {
                Task {
                    await currencyVM.networkRequest()
                }
            }){
                Text("Convert")
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(5)
        }
        .padding()
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
