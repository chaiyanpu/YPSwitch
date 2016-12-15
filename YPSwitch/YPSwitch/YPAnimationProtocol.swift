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
    
    func playAnimation(_ bgLayer: CAShapeLayer, thumbLayer : CAShapeLayer,stokeLayer:CAShapeLayer)
    
    
    
    func deselectAnimation(_ bgLayer : CAShapeLayer, thumbLayer : CAShapeLayer,stockLayer:CAShapeLayer)
    
    
    
}

extension YPAnimationProtocol{
    
    var bgTargetColor:UIColor{
        return UIColor.green
    }
    
    var thumbTargetColor:UIColor{
        return UIColor.darkGray
    }
    
    func playAnimation(_ bgLayer: CAShapeLayer, thumbLayer : CAShapeLayer,stokeLayer:CAShapeLayer){
        
    }
    
    func deselectAnimation(_ bgLayer : CAShapeLayer, thumbLayer : CAShapeLayer,stockLayer:CAShapeLayer){
        
    }
    

}
