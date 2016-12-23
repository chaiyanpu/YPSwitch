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
    
    func playAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?,to:Float){
        fatalError("override method in subclass")
    }
   
}
