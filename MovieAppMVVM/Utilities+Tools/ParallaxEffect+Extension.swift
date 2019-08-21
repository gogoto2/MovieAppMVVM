//
//  ParallaxEffect+Extension.swift
//  NewsExpress
//
//  Created by Macbook on 16/06/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func applyMotionEffect (toView view:UIView, magnitude:Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
    }
}

//applyMotionEffect(toView: backgroundImageView, magnitude: 10)
//applyMotionEffect(toView: logoImageView, magnitude: -20)

