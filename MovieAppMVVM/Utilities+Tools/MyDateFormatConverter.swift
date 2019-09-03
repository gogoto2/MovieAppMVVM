
import Foundation
import UIKit

func dateFormatChange(yourdate: String, currentFormat: String, requiredFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = currentFormat
    let date = dateFormatter.date(from: yourdate)
    dateFormatter.dateFormat = requiredFormat
    return dateFormatter.string(from: date!)
}
