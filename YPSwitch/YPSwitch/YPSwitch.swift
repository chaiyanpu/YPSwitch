//
//  YPSwitch.swift
//  YPSwitch
//
//  Created by chai on 2016/12/14.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit

enum YPSwitchType {
    
    case switchOne
    case switchTwo
    case switchThree
    case switchFour
    
    var animation:YPAnimation{
        switch self {
        case .switchOne:
            return YPAnimation()
        case .switchTwo:
            return YPPopAnimation()
        case .switchThree:
            return YPAnimation()
        case .switchFour:
            return YPAnimation()
        }
    }
}

class YPSwitch:UIControl{
    
    //Layer collection
    open var animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?
    
    open var animation:YPAnimation?
    //边的宽度
    open var stokeLineWidth:CGFloat = 2
    //thumb离边的距离
    open var thumbInset : CGFloat = 1
    //白色背景
    open var strokeColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
    //绿色背景
    open var selectedColor = UIColor(red: 111/255.0, green: 216/255.0, blue: 100/255.0, alpha: 1.0)
    
    var on: Bool = false
    var isTap: Bool = false
    
    var touchPoint:CGPoint!

    init(position:CGPoint,size:CGSize = CGSize(width:60,height:35),type:YPSwitchType){
        super.init(frame:CGRect(origin: position, size: size))
        backgroundColor = UIColor.clear
        animation = type.animation
        self.buildLayer(size)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool{
        isTap = true
        touchPoint = touch.location(in: self)
        
        let percent : Float = Float(touchPoint.x) / Float(self.frame.width)
        animation?.playAnimation(animationLayer:animationLayer)
//        animation.animateToProgress(percent)
        return true
        
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool{
        isTap = false
//        animationView.pop_removeAllAnimations()
//        let currentTouch = touch.location(in: self)
//        
//        var percent : CGFloat = currentTouch.x / self.frame.width
//        percent = max(percent, 0.0)
//        percent = min(percent, 1.0)
//        animationView.progress = percent
//        animationView.setNeedsDisplay()
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?){
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
    
    override func cancelTracking(with event: UIEvent?){
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
//MARK: - 构造Layer
extension YPSwitch{
    
    func buildLayer(_ size:CGSize){
        let width = size.width
        let height = size.height
        
        let strokeBackgroundLayer = CAShapeLayer()
        let backgroundLayer = CAShapeLayer()
        let thumbLayer = CAShapeLayer()
        
        strokeBackgroundLayer.path = backgroundPath(CGRect(x: 0,y: 0,width: width,height:height)).cgPath
        strokeBackgroundLayer.strokeColor = strokeColor.cgColor
        strokeBackgroundLayer.fillColor = selectedColor.cgColor
        strokeBackgroundLayer.lineWidth = stokeLineWidth
        
        backgroundLayer.path = backgroundPath(CGRect(x: stokeLineWidth/2,y: stokeLineWidth/2,width: width - stokeLineWidth,height: height - stokeLineWidth)).cgPath
        backgroundLayer.fillColor = UIColor.white.cgColor
        
        thumbLayer.path = UIBezierPath(ovalIn: CGRect(x: thumbInset/2 + stokeLineWidth/2, y: thumbInset/2 + stokeLineWidth/2, width: height - thumbInset - stokeLineWidth, height: height - thumbInset - stokeLineWidth)).cgPath
        
        thumbLayer.strokeColor = strokeColor.cgColor
        thumbLayer.fillColor = UIColor.white.cgColor
        thumbLayer.lineWidth = 0.5
        thumbLayer.shadowColor = UIColor.black.cgColor
        thumbLayer.shadowOpacity = 0.3
        thumbLayer.shadowRadius = 1
        thumbLayer.shadowOffset = CGSize(width: 0, height: 2)
        
        layer.addSublayer(strokeBackgroundLayer)
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(thumbLayer)
        
        //add layer with animation to the truple
        self.animationLayer = (bgLayer: backgroundLayer, thumbLayer: thumbLayer,stokeLayer:strokeBackgroundLayer)
    }
    
    func backgroundPath(_ frame: CGRect) -> UIBezierPath {
        
        ////draw path
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height), cornerRadius: frame.height/2)
        return rectanglePath
    }

}


