//
//  YPNativeAnimation.swift
//  YPSwitch
//
//  Created by chai on 2016/12/16.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit

class YPNativeAnimation:YPAnimation{

    //MARK: - YPAnimationProtocol,animation method.
    override func playAnimation(animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?,to target:AnimationTarget){
        
        guard animationLayer != nil  else {
            fatalError("animationLayer is nil")
        }
        
        animationTarget = target
        strokeBackgroundAnimation(animationLayer!.stokeLayer)
        backgroundAnimation(animationLayer!.bgLayer)
        thumbAnimation(animationLayer!.thumbLayer)
        
    }
    
    // MARK: layer animation
    
    // MARK: stroke
    func strokeBackgroundAnimation(_ stokeLayer:CAShapeLayer) {
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = animDuration
        groupAnimation.animations = [strokeColorAnimation(stokeLayer), strokeFillColorAnimation(stokeLayer)]
        keepAnimation(groupAnimation)
        stokeLayer.add(groupAnimation, forKey: "strokeBackgroundAnimations")
    }
    
    func strokeColorAnimation(_ stokeLayer:CAShapeLayer)-> CABasicAnimation {
        
        let strokeAnim = CABasicAnimation(keyPath: "strokeColor")
        strokeAnim.fromValue = value(animationTarget, onValue: stokeLayer.strokeColor, offValue: stokeLayer.fillColor)
        strokeAnim.toValue = value(animationTarget, onValue: stokeLayer.fillColor, offValue: stokeLayer.strokeColor)
        strokeAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return strokeAnim
    }
    
    func strokeFillColorAnimation(_ stokeLayer:CAShapeLayer)-> CABasicAnimation {
        
        let fillAnim = CABasicAnimation(keyPath: "fillColor")
        if animationTarget == .close {
            fillAnim.fromValue = stokeLayer.fillColor
            fillAnim.toValue = stokeLayer.strokeColor
            fillAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        }
        return fillAnim
    }
    
    // MARK: background
    func backgroundAnimation(_ bgLayer:CAShapeLayer) {
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = animDuration
        groupAnimation.animations = [backgroundFillAnimation(bgLayer)]
        keepAnimation(groupAnimation)
        bgLayer.add(groupAnimation, forKey: "backgroundAnimations")
       
    }
    
    func backgroundFillAnimation(_ stokeLayer:CAShapeLayer)-> CAKeyframeAnimation {
        
        guard animationSize != nil else {
            fatalError("animationSize is nil")
        }
        let beginPath = backgroundPath(CGRect(x: 1, y: 1, width: animationSize!.width - 2, height: animationSize!.height - 2))
        let endPath = backgroundPath(CGRect(x: animationSize!.width/2, y: animationSize!.height/2, width: 0, height: 0))
        
        let fillAnim = CAKeyframeAnimation(keyPath: "path")
        
        fillAnim.values = [
            value(animationTarget,onValue: beginPath, offValue: endPath).cgPath,
            value(animationTarget,onValue: endPath, offValue: beginPath).cgPath]
        
        fillAnim.keyTimes = [
            NSNumber(value: 0.0 as Float),
            NSNumber(value: 1.0 as Float)]
        
        fillAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return fillAnim
    }
    
    func backgroundPath(_ frame: CGRect) -> UIBezierPath {
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height), cornerRadius: frame.height/2)
        return rectanglePath
    }
    
    // MARK: thumb
    func thumbAnimation(_ thumbLayer:CAShapeLayer){
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = animDuration
        groupAnimation.animations = [thumbPositionAnimation()]
        keepAnimation(groupAnimation)
        thumbLayer.add(groupAnimation, forKey: "thumbAnimations")
    }
    
    func thumbPositionAnimation()-> CABasicAnimation {
        
        guard animationSize != nil else {
            fatalError("animationSize is nil")
        }
        let posAnim = CABasicAnimation(keyPath: "position")
        let leftValue = NSValue(cgPoint:CGPoint(x: 0, y: 0))
        let rightValue = NSValue(cgPoint:CGPoint(x: (animationSize!.width - animationSize!.height), y: 0))
        posAnim.fromValue = value(animationTarget,onValue: leftValue, offValue: rightValue)
        posAnim.toValue = value(animationTarget,onValue: rightValue, offValue: leftValue)
        posAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return posAnim
    }
    
}

