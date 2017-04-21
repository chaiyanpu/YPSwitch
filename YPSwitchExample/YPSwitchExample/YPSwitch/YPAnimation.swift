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

    var animationSize:CGSize?
    
    var animationTarget:AnimationTarget = .open
    
    var animDuration = 1.0
    
    func playAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?,to target:AnimationTarget){
        fatalError("override method in subclass")
    }
    
}
