//
//  YPAnimationProtocol.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit

typealias AnimationTarget = YPSwitchResult

protocol YPAnimationProtocol{
    
    var progress:CGFloat{get}
    
    var animationTarget:AnimationTarget{set get}
    
    var animDuration:Float{get}
    
    func playAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?,to target:AnimationTarget)
    
    //保持动画的存在
    func keepAnimation(_ animation:CAAnimation)
    
}

extension YPAnimationProtocol{
    
    var animationTarget:AnimationTarget{
        return .open
    }
    
    var animDuration:Float{
        return 1.0
    }
    
    var progress:CGFloat{
        return 0.0
    }
    
    
    //保持动画的存在
    func keepAnimation(_ animation:CAAnimation){
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
    }
}
