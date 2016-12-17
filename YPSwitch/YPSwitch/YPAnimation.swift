//
//  YPAnimation.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit

class YPAnimation:YPAnimationProtocol{
    
    
    //default
    var width : CGFloat = 60
    var height : CGFloat = 35
    
    let thumbInset : CGFloat = 0
    
    var strokeColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
    var selectedColor = UIColor(red: 111/255.0, green: 216/255.0, blue: 100/255.0, alpha: 1.0)

    
    init() {
        

        //构造layer
    }
    
       
    
    //MARK: - YPAnimationProtocol
    var bgTargetColor:UIColor?
    
    var thumbTargetColor:UIColor?
    
    func playAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?,to:Float){
        fatalError("override method in subclass")
    }
    
    func deselectAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?){
        fatalError("override method in subclass")
    }

    
   
}
