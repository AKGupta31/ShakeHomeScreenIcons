//
//  AnimationUtility.swift
//  CropslyTest
//
//  Created by Admin on 18/01/22.
//

import UIKit

class AnimationUtility {
    //singleton
    static let shared = AnimationUtility()
    
    private init(){}
    
    func getShakeAnimation() -> CAAnimation{
        let animation = CABasicAnimation(keyPath: "transform")
        let transform = CATransform3DMakeRotation(0.08, 0, 0, 1.0)
        animation.toValue = NSValue(caTransform3D: transform)
        animation.autoreverses = true
        animation.duration = 0.1
        animation.repeatCount = Float.infinity
        return animation
    }
}
