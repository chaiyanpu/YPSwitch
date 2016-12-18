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
    
    func playAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?,to:Float){
        fatalError("override method in subclass")
    }
    
    func deselectAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?){
        fatalError("override method in subclass")
    }

    
   
}
