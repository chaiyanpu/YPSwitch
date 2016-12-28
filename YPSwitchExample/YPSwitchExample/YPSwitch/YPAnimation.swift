//
//  YPAnimation.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit
//template
func value<T>(_ state:SwitchState,onValue:T,offValue:T) -> T{
    return state == .open ? onValue : offValue
}
class YPAnimation:YPAnimationProtocol{
       
    //MARK: - YPAnimationProtocol
    var bgTargetColor:UIColor?
    
    var thumbTargetColor:UIColor?
    
    var animationSize:CGSize?
   
    var progress:CGFloat!
    
    var animationTarget:AnimationTarget = .open
    
    var animDuration = 1.0
    
    func playAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?,to target:AnimationTarget){
        fatalError("override method in subclass")
    }
    
    //保持动画的存在
//    func keepAnimation(_ animation:CAAnimation){
//        animation.isRemovedOnCompletion = false
//        animation.fillMode = kCAFillModeForwards
//    }
    
}
