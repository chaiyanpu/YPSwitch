//
//  YPAnimationProtocol.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit
protocol YPAnimationProtocol{
    
    var bgTargetColor:UIColor{get}
    
    var thumbTargetColor:UIColor{get}
    
    func playAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?,to:Float)
    
}

extension YPAnimationProtocol{
    
    var bgTargetColor:UIColor{
        return UIColor.green
    }
    
    var thumbTargetColor:UIColor{
        return UIColor.darkGray
    }
    
}
