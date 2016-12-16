//
//  YPAnimation.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit

class YPAnimation:YPAnimationProtocol{
    
    var frame:CGRect
    init(_ layoutFrame:CGRect) {
        self.frame = layoutFrame
        
        //构造layer
    }
    
    // MARK: - variable declararion
    var strokeBackgroundLayer : CAShapeLayer = CAShapeLayer()
    var backgroundLayer : CAShapeLayer = CAShapeLayer()
    var thumbLayer : CAShapeLayer = CAShapeLayer()
    
    
    //MARK: - YPAnimationProtocol
    var bgTargetColor:UIColor?
    
    var thumbTargetColor:UIColor?
    
    func playAnimation(bgLayer: CAShapeLayer, thumbLayer : CAShapeLayer,stokeLayer:CAShapeLayer){
        fatalError("override method in subclass")
    }
    
    func deselectAnimation(bgLayer : CAShapeLayer, thumbLayer : CAShapeLayer,stockLayer:CAShapeLayer){
        fatalError("override method in subclass")
    }

    
   
}
