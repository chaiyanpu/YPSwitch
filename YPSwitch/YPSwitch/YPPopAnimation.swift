//
//  YPPopAnimation.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit

class YPPopAnimation:YPAnimation{
    
    
    override init(_ layoutFrame:CGRect){
        super.init(layoutFrame)
        
    }
    
    //MARK: - YPAnimationProtocol,animation method.
    override func playAnimation(bgLayer: CAShapeLayer, thumbLayer : CAShapeLayer,stokeLayer:CAShapeLayer){
        
        print("hehh")
    }
    
    override func deselectAnimation(bgLayer : CAShapeLayer, thumbLayer : CAShapeLayer,stockLayer:CAShapeLayer){
        
    }
    
}

