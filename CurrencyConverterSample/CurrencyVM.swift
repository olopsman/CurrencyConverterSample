//
//  CurrencyVM.swift
//  CurrencyConverterSample
//
//  Created by Paulo Orquillo on 15/04/23.
//

import Foundation

class CurrencyVM: ObservableObject {
    @Published var amount: Double = 0
    @Published var convertedAmount: Double = 0
    @Published var currency = "nzd"
    @Published var newCurrencyValue = "php"

    //array of all the currencies in the world
    var currencies = ["usd", "eur", "jpy", "gbp", "aud", "cad", "chf", "cny", "sek", "nzd", "mxn", "sgd", "hkd", "inr", "zar", "krw", "try", "rub", "brl", "twd", "dkk", "pln", "thb", "nok", "idr", "huf", "czk", "ils", "clp", "php", "aed", "cop", "sar", "myr", "ron", "sek", "nzd", "mxn", "sgd", "hkd", "inr", "zar", "krw", "try", "rub", "brl", "twd", "dkk", "pln", "thb", "nok", "idr", "huf", "czk", "ils", "clp", "php", "aed", "cop", "sar", "myr", "ron"].sorted()
    
    func networkRequest() async {
        //create url
        let url = URL(string: "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/\(currency)/\(newCurrencyValue).json")
        
        //url can be optional
        guard url != nil else { return }
        //create request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        //create the url session singelton
        let session = URLSession.shared
        
        //create the data tasks
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil && data != nil {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
                    print(dictionary)
                    let newCurrencyValue = dictionary["\(self.newCurrencyValue)"] as! Double
                    DispatchQueue.main.async {
                        self.convertedAmount = Double(self.amount) * newCurrencyValue
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
}
