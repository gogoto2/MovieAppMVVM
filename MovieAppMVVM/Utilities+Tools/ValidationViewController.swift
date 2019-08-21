
import Foundation
import UIKit

class ValidationViewController {

    // Name validation regex
    /**
     - parameter name: The any text field string, requested for name validations
     
     */
    class func isValidName(_ name : String) -> Bool {
        let nameRegEx = "[a-zA-z]+([ '-][a-zA-Z]+)*$"
        let range = name.range(of: nameRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return result
    }
    
    // Validate phone number string.
    /**
     :param phoneNumber The number from text field
     */
    class func isPhoneValidate(_ phoneNumber: String) -> Bool {
        let phoneRegex = "[0-9]{10,10}$"
        let range = phoneNumber.range(of: phoneRegex, options:.regularExpression)
        let result = range != nil ? true : false
        return result
    }
    
    // Email validation regex
    /**
     - parameter testStr: The email id string
     */
    class func isValidEmail(_ testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return result
    }
}
