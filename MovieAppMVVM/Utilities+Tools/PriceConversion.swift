
import Foundation

func roundFigurePrice(projectPrice: Int) -> String {
    
    var fullPrice: String = ""
    
    if (projectPrice >= 1000 && projectPrice <= 99999) {
        var money = Double(projectPrice)/1000.00
        money = (money * 100).rounded() / 100
        fullPrice = "\(money) Thousands"
        print(fullPrice)
    }
    else if (projectPrice >= 100000 && projectPrice <= 9999999) {
        var money = Double(projectPrice)/100000.00
        money = (money * 100).rounded() / 100
        fullPrice = "\(money) Lacs"
        print(fullPrice)
    }
    else if (projectPrice >= 10000000 && projectPrice <= 999999999) {
        var money = Double(projectPrice)/10000000.00
        money = (money * 100).rounded() / 100
        fullPrice = "\(money) Crores"
        print(fullPrice)
    }
    return fullPrice
}

func priceFormatWithCommaSeperate(strPhone : String)-> String {
    
    var strUpdated = strPhone
    
    if strPhone.count == 4 {
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 1))
    } else if strPhone.count == 5 {
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 2))
    } else if strPhone.count == 6 {
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 1))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 4))
    } else if strPhone.count == 7 {
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 2))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 5))
    } else if strPhone.count == 8 {
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 1))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 4))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 7))
    } else if strPhone.count == 9 {
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 2))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 5))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 8))
    } else if strPhone.count == 10 {
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 1))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 4))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 7))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 10))
    } else if strPhone.count == 11 {
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 2))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 5))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 8))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 11))
    } else if strPhone.count == 12 {
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 1))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 4))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 7))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 10))
        strUpdated.insert(",", at: strUpdated.index(strUpdated.startIndex, offsetBy: 13))
    }
    return strUpdated
}

extension String {
    var trimFirstChar : String {
        mutating get {
            self.remove(at: self.startIndex)
            return self
        }
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

func isValidEmail(_ testStr: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let range = testStr.range(of: emailRegEx, options:.regularExpression)
    let result = range != nil ? true : false
    return result
}
