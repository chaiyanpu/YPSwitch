//
//  YPAnimation.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit

class YPAnimation:YPAnimationProtocol{
       
    //MARK: - YPAnimationProtocol
    var bgTargetColor:UIColor?
    
    var thumbTargetColor:UIColor?
    
    var animationSize:CGSize?
    
    var animDuration = 1.0

    enum AnimationTarget {
        case on
        case off
    }
    
    var progress:CGFloat!
    
    var animationTarget:AnimationTarget = .on
    
    
    func playAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?,to:Float){
        fatalError("override method in subclass")
    }
    
    //template
    func value<T>(onValue:T,offValue:T) -> T{
        return animationTarget == .on ? onValue : offValue
    }
    
}
