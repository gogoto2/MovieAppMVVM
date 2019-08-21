
import Foundation
import UIKit

open class LoadingOverlay {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    func showProgressView(_ view: UIView) {
        
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        containerView.backgroundColor = UIColor.clear
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        progressView.layer.cornerRadius = 10
        containerView.addSubview(progressView)
        
        progressView.backgroundColor = UIColor(white: 0x444444, alpha: 0.7)
        progressView.clipsToBounds = true
        
        activityIndicator.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        progressView.addSubview(activityIndicator)
        
        view.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    
    func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
