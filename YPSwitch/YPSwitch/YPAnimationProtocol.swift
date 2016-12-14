//
//  YPAnimationProtocol.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit
protocol YPAnimationProtocol{
    func playAnimation(_ bgLayer: CAShapeLayer, thumbLayer : CAShapeLayer)
    
    func deselectAnimation(_ bgLayer : CAShapeLayer, thumbLayer : CAShapeLayer, defaultTextColor : UIColor, defaultIconColor : UIColor)
    
    func selectedState(_ bgLayer : CAShapeLayer, thumbLayer : CAShapeLayer)
}

