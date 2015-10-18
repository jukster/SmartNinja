// Smartninja 2015, lesson2
// Marko Jukić

class Currency: CustomStringConvertible {
    var currencyName: String
    
    var description: String {
        get {
            return currencyName
        }
    }
    
    init (_ currencyName: String){
        self.currencyName = currencyName
    }
}

class MoneyConverter {
    
    let rates: [String:Double] = ["EURUSD": 1.1, "EUREUR": 1.0]

    func convert (value: Double, startCurrency: Currency, targetCurrency: Currency) -> (convertedValue : Double, targetCurrency: Currency)? {
        
        if let thisRate = rates[startCurrency.currencyName + targetCurrency.currencyName] {
            return (value * thisRate, targetCurrency)
        }
        else {
            print("Za \(startCurrency.currencyName)\(targetCurrency.currencyName) nimam tečaja.")
            return nil
        }
    }
    
    func displayRates() -> String {
        return "Te tečaje imam: " + rates.description
    }
}

var eur = Currency("EUR")

var gbp = Currency("GBP")

var usd = Currency("USD")


var aConverter = MoneyConverter()

print(aConverter.convert(20, startCurrency: eur, targetCurrency: gbp))

print(aConverter.convert(30, startCurrency: eur, targetCurrency: usd))

print(aConverter.displayRates())