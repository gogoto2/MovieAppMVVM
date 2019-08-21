
import UIKit

@IBDesignable class ShadowOfTableView: UITableView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    @IBInspectable var shadowOffSetWidth: CGFloat = 0.7
    @IBInspectable var shadowOffSetHeight: CGFloat = 0.7
    @IBInspectable var shadowColor: UIColor = UIColor(hex: "424242")
    @IBInspectable var shadowOpacity: CGFloat = 0.3
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}
