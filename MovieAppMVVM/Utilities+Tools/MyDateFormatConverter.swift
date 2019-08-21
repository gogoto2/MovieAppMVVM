
import Foundation
import UIKit

//extension UIViewController {
//    
//    func dateFormatChange(yourdate: String, currentFormat: String, requiredFormat: String) -> String {
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = currentFormat
//        let txnDateIs = dateFormatter.date(from: yourdate)
//        dateFormatter.dateFormat = requiredFormat
//        let newTxnDate = dateFormatter.string(from: txnDateIs!)
//        dateFormatter.dateFormat = requiredFormat
//        let txnDateInString = dateFormatter.date(from: newTxnDate)!
//        let svevevg = dateFormatter.string(from: txnDateInString)
//        return svevevg
//    }
//}
//
//extension UITableViewCell {
//    
//    func dateFormatChange(yourdate: String, currentFormat: String, requiredFormat: String) -> String {
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = currentFormat
//        let txnDateIs = dateFormatter.date(from: yourdate)
//        dateFormatter.dateFormat = requiredFormat
//        let newTxnDate = dateFormatter.string(from: txnDateIs!)
//        dateFormatter.dateFormat = requiredFormat
//        let txnDateInString = dateFormatter.date(from: newTxnDate)!
//        let svevevg = dateFormatter.string(from: txnDateInString)
//        return svevevg
//    }
//}
//
//extension UICollectionViewCell {
//
//    func dateFormatChange(yourdate: String, currentFormat: String, requiredFormat: String) -> String {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = currentFormat
//        let txnDateIs = dateFormatter.date(from: yourdate)
//        dateFormatter.dateFormat = requiredFormat
//        let newTxnDate = dateFormatter.string(from: txnDateIs!)
//        dateFormatter.dateFormat = requiredFormat
//        let txnDateInString = dateFormatter.date(from: newTxnDate)!
//        let svevevg = dateFormatter.string(from: txnDateInString)
//        return svevevg
//    }
//}

func dateFormatChange(yourdate: String, currentFormat: String, requiredFormat: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = currentFormat
    let txnDateIs = dateFormatter.date(from: yourdate)
    dateFormatter.dateFormat = requiredFormat
    let newTxnDate = dateFormatter.string(from: txnDateIs!)
    dateFormatter.dateFormat = requiredFormat
    let txnDateInString = dateFormatter.date(from: newTxnDate)!
    let svevevg = dateFormatter.string(from: txnDateInString)
    return svevevg
}
