
import UIKit

@IBDesignable
class EnterMobileNumberTextField: UITextField {

    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        if let image = rightImage {
            rightViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: rightPadding, y:0, width: 20, height: 20))
            imageView.image = image
            
            let width = rightPadding + 20
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            
            rightView = view
            
        } else {
            rightViewMode = .never
        }
    }
}
