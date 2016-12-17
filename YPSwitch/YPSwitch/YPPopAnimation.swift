//
//  YPPopAnimation.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit

class YPPopAnimation:YPAnimation{
    
    
    override init(){
        
        
    }
    
    //MARK: - YPAnimationProtocol,animation method.
    override func playAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)){
        
        print("hehh")
    }
    
    override func deselectAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)){
        
    }
    
}

