
import UIKit

extension UIButton {
    func buttonShadow() {
        self.layer.shadowColor = UIColor(hex: "424242").cgColor
        self.layer.shadowOffset = CGSize(width: 0.7, height: 0.7)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
    }
}
