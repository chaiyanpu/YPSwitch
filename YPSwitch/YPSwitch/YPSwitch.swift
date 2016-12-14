//
//  YPSwitch.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import Foundation
import UIKit

typealias YPSwitchTpye = (YPSwitchBG?,YPSwitchThumb?)

enum YPSwitchEnum<YPSwitchTpye> {
    case swiftchOne()
}

class YPSwitch:UIControl{
    
    var switchStokeBG:YPSwitchBG?
    var switchFillBG:CAShapeLayer?
    var switchThumb:YPSwitchThumb?
    
    var on: Bool = false
    var isTapGesture: Bool = false
    
    var animationView : YPAnimation!
    var _previousTouchPoint:CGPoint!
    
    
    init(frame: CGRect, animationType : AnimationType) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        isTapGesture = true
//        _previousTouchPoint = touch.location(in: self)
//        
//        let percent : Float = _previousTouchPoint.x / self.frame.width
//        animationView.animateToProgress(percent)
//        
        return true
        
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        isTapGesture = false
//        animationView.pop_removeAllAnimations()
//        let currentTouch = touch.location(in: self)
//        
//        var percent : CGFloat = currentTouch.x / self.frame.width
//        percent = max(percent, 0.0)
//        percent = min(percent, 1.0)
//        animationView.progress = percent
//        animationView.setNeedsDisplay()
//        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
//        if(isTapGesture){
//            if(self.on){
//                animationView.animateToProgress(0.0)
//            }else{
//                animationView.animateToProgress(1.0)
//            }
//            self.on = !self.on
//        }else{
//            endToggleAnimation()
//        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
//        if(isTapGesture){
//            if(self.on){
//                animationView.animateToProgress(0.0)
//            }else{
//                animationView.animateToProgress(1.0)
//            }
//            self.on = !self.on
//        }else{
//            endToggleAnimation()
//        }
    }
    
    func endToggleAnimation(){
        
//        var newProgress : CGFloat!
//        if(animationView.progress >= 0.5)
//        {
//            newProgress = 1.0
//            animationView.animateToProgress(newProgress)
//        }else{
//            newProgress = 0.0
//            animationView.animateToProgress(newProgress)
//        }
//        
//        if(on && newProgress == 0)
//        {
//            on = false
//            sendActions(for: UIControlEvents.valueChanged)
//        }else if(!on && newProgress == 1){
//            on = true
//            sendActions(for: UIControlEvents.valueChanged)
//        }
        
    }
    
    func setOn(_ on: Bool, animated: Bool){
        
//        var progress : CGFloat = 0.0
//        if on {
//            progress = 1.0
//        }
//        if(animated){
//            animationView.animateToProgress(progress)
//        }else{
//            animationView.progress = progress
//        }
   
    }

    
}

class YPSwitchBG:UIControl{

}

class YPSwitchThumb:UIControl{

}
