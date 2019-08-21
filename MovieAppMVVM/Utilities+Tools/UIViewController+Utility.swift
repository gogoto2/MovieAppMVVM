//
//  UIViewController+Utility.swift
//  Late Lateef
//
//  Created by subhajit halder on 23/12/16.
//  Copyright © 2016 Tanmoy. All rights reserved.
//

import Foundation
import UIKit
//import FCAlertView
import CoreData

let kAlertTintColor = UIColor(red: CGFloat(0.49), green: CGFloat(0.03), blue: CGFloat(0.31), alpha: CGFloat(1.0))

typealias AlertCompletion = (_ object: Any?,_ actionId: Int?) -> Void

extension UIViewController {
    
    
    
//    func getNoOfCartItems() -> Int16 {
//
//        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
//
//        let result = try? DatabaseController.getContext().fetch(request)
//
//        var totalQuantity = Int16(0)
//        if result != nil {
//            if result?.count != 0 {
//                for i in result! {
//                    totalQuantity = totalQuantity + i.quantity
//                }
//            }
//
//        }
//
//
//        print("No of cart Items: \(totalQuantity)")
//
//        return totalQuantity
//    }

    @IBAction func back(_ sender: Any) {
//        _ = self.navigationController?.popViewController(animated: true)
        self.dismissDetail()
    }
    
//    @IBAction func cart(_ sender: Any) {
//        guard let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as? CartVC else {return}
//        
////        let navCtrl = UINavigationController(rootViewController: cartVC)
////        navCtrl.isNavigationBarHidden = true
////
////
////        self.present(navCtrl, animated: true, completion: nil)
//        
//        self.navigationController?.pushViewController(cartVC, animated: true)
//        
//    }
    
    
    
    @objc(positionForBar:) func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
//    func showReachabilityAlert() {
//        let alert = FCAlertView()
//        
//        alert.makeAlertTypeCaution()
//        
//        alert.showAlert(inView: self,
//                        withTitle: "No Internet",
//                        withSubtitle: "Please check you Internet connection.",
//                        withCustomImage: nil,
//                        withDoneButtonTitle: "OK",
//                        andButtons: nil)
//    }
    
//    func showSuccessAlert(title: String, message:String) {
//        let alert = FCAlertView()
//
//        alert.makeAlertTypeSuccess()
//
//        alert.showAlert(inView: self,
//                        withTitle: title,
//                        withSubtitle: message,
//                        withCustomImage: nil,
//                        withDoneButtonTitle: "OK",
//                        andButtons: nil)
//    }
    
//    func showSuccessAlert(title: String, message:String,  handler: @escaping AlertCompletion) {
//        let alert = SHAlertController(type: .success, title: title, body: message, buttonTitle: "OK")
//        alert.actionPerformed { (action) in
//            handler(nil, action)
//        }
//        self.present(alert, animated: true, completion: .none)
//    }
    
//    func showErrorAlert(title: String, message:String) {
////        let alert = FCAlertView()
////
////        alert.makeAlertTypeWarning()
////
////        alert.showAlert(inView: self,
////                        withTitle: title,
////                        withSubtitle: message,
////                        withCustomImage: nil,
////                        withDoneButtonTitle: "OK",
////                        andButtons: nil)
//
//        let alert = SHAlertController(type: .error, title: title, body: message, buttonTitle: "OK")
//        self.present(alert, animated: true, completion: .none)
//    }
    
//    func showErrorAlert(title: String, message:String, handler: @escaping AlertCompletion) {
//        let alert = SHAlertController(type: .error, title: title, body: message, buttonTitle: "OK")
//        alert.actionPerformed { (action) in
//            handler(nil, action)
//        }
//        self.present(alert, animated: true, completion: .none)
//
//    }
//
    func showErrorAlert(title: String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionOk = UIAlertAction(title: "Ok", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(actionOk)
//        self.present(alert, animated: true, completion: .none)
        DispatchQueue.main.async(execute: {() -> Void in
            if !(self.presentedViewController is (UIAlertController)) {
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
//
//    func showAlert(withTitle title: String?, andMessage msg: String?) {
//        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
//        let firstView: UIView? = alertController.view.subviews.first
//        let secView: UIView? = firstView?.subviews.first
//        secView?.backgroundColor = UIColor(red: CGFloat(0.996), green: CGFloat(0.996), blue: CGFloat(0.980), alpha: CGFloat(1.00))
//        secView?.layer.cornerRadius = 3.0
//        alertController.view.tintColor = kAlertTintColor
//        let actionOk = UIAlertAction(title: "Ok", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
//            alertController.dismiss(animated: true, completion: nil)
//        })
//        alertController.addAction(actionOk)
//        DispatchQueue.main.async(execute: {() -> Void in
//            if !(self.presentedViewController is (UIAlertController)) {
//                self.present(alertController, animated: true, completion: nil)
//            }
//        })
//    }
//
    
//    func showAlert(withTitle title: String?, andMessage msg: String?, handler: @escaping AlertCompletion) {
//        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
//        let firstView: UIView? = alertController.view.subviews.first
//        let secView: UIView? = firstView?.subviews.first
//        secView?.backgroundColor = UIColor(red: CGFloat(0.996), green: CGFloat(0.996), blue: CGFloat(0.980), alpha: CGFloat(1.00))
//        secView?.layer.cornerRadius = 3.0
//        alertController.view.tintColor = kAlertTintColor
//        let actionOk = UIAlertAction(title: "Ok", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
//            alertController.dismiss(animated: true, completion: nil)
//            DispatchQueue.main.async(execute: {() -> Void in
//                handler(nil, 0)
//            })
//        })
//        alertController.addAction(actionOk)
//        DispatchQueue.main.async(execute: {() -> Void in
//            if !(self.presentedViewController is (UIAlertController)) {
//                self.present(alertController, animated: true, completion: nil)
//            }
//        })
//    }
    
//    func showUpdateAlert (handler: @escaping AlertCompletion) {
//        let alert = UpdateNowVC(type: .appAlert, title: "Good news! A new version of our app is available", body: "", buttonTitle: "UPDATE NOW")
//        alert.actionPerformed { (action) in
//            handler(nil, action)
//        }
//        self.present(alert, animated: true, completion: .none)
//        
//    }
    
}

extension UIViewController {
    func configureChildViewController(childController: UIViewController, onView: UIView?) {
        var holderView = self.view
        if let onView = onView {
            holderView = onView
        }
        addChild(childController)
        holderView?.addSubview(childController.view)
        constrainViewEqual(holderView: holderView!, view: childController.view)
        childController.didMove(toParent: self)
        childController.willMove(toParent: self)
    }
    
    func removeChildViewController(childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
    
    
    func constrainViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        //pin 100 points from the top of the super
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                        toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                           toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                         toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }}
