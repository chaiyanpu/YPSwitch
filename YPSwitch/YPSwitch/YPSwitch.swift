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
            return YPNativeAnimation()
        case .switchTwo:
            return YPPopAnimation()
        case .switchThree:
            return YPAnimation()
        case .switchFour:
            return YPAnimation()
        }
    }
}

enum YPSwitchResult{
    
    case open
    case close
    
    func on(_ on:() -> ()) -> YPSwitchResult{
        switch self{
        case .open:
            on()
        default:
            break
        }
        return self
    }
    
    func off(_ off:() -> ()) -> YPSwitchResult {
        switch self {
        case .close:
            off()
        default:
            break
        }
        return self
    }
}

class YPSwitch:UIControl{
    
    //CompleteHandler
    var handler:((_ action:YPSwitchResult)->())?
    
    //Layer collection
    open var animationLayer:(bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer,stokeLayer:CAShapeLayer)?
    
    open var animation:YPAnimation?
    //边的宽度
    open var stokeLineWidth:CGFloat = 2
    //thumb离边的距离
    open var thumbInset : CGFloat = 1
    
    //灰色边
    open var strokeColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
    //未选中背景颜色
    open var unselectedColor = UIColor.white
    //选中背景
    open var selectedColor = UIColor(red: 111/255.0, green: 216/255.0, blue: 100/255.0, alpha: 1.0)
    //滑块颜色
    open var trumbColor = UIColor.white
    
    var switchState: YPSwitchResult = .close
    fileprivate var isOn:Bool = false
    fileprivate var isTap: Bool = false
    
    fileprivate var touchPoint:CGPoint!
    fileprivate var endPoint:CGPoint!

    init(position:CGPoint,size:CGSize = CGSize(width:60,height:35),type:YPSwitchType,_ hadler:@escaping (_ action:YPSwitchResult)->()){
        super.init(frame:CGRect(origin: position, size: size))
        backgroundColor = UIColor.clear
        animation = type.animation
        animation?.animationSize = size
        self.buildLayer(size)
        self.handler = hadler
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool{
        
        isTap = true
        touchPoint = touch.location(in: self)
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool{
        
        isTap = false
        endPoint = touch.location(in: self)
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?){
        let endPoint = touch?.location(in: self)
        if let point = endPoint{
            if point.y < self.frame.size.height * 2 && point.y > -self.frame.size.height{
                animationByState()
            }
        }
    }
    
    override func cancelTracking(with event: UIEvent?){
         animationByState()
    }
    
    //根据状态决定行为
    fileprivate func animationByState(_ endPoint:CGPoint? = CGPoint(x: 0, y: 0)){
        //移除所有 Animation
        layer.removeAllAnimations()
        switch isTap {
        case true:
            if isOn{
                animation?.playAnimation(animationLayer: animationLayer, to: 0)
            }else{
                animation?.playAnimation(animationLayer: animationLayer, to: 1)
            }
            //TODO:回调
            callBack()
        case false:
            //TODO: - 判断结束拖拽位置
            endToggleAnimation()
        }
    }
    
    fileprivate func endToggleAnimation(){
        
        switch isOn {
        case true:
            if touchPoint.x - endPoint.x - self.frame.size.width/3  > 0{
                animation?.playAnimation(animationLayer: animationLayer, to: 0)
                callBack()
            }
        case false:
            if endPoint.x - touchPoint.x - self.frame.size.width/3 > 0{
                animation?.playAnimation(animationLayer: animationLayer, to: 1)
                callBack()
            }
        }
    }
    
    private func callBack(){
        isOn = !isOn
        handler?(isOn == true ? .open : .close)
    }
    
}

//MARK: - 构造Layer
extension YPSwitch{
    
    fileprivate func buildLayer(_ size:CGSize){
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
        backgroundLayer.fillColor = unselectedColor.cgColor
        
        thumbLayer.path = UIBezierPath(ovalIn: CGRect(x: thumbInset/2 + stokeLineWidth/2, y: thumbInset/2 + stokeLineWidth/2, width: height - thumbInset - stokeLineWidth, height: height - thumbInset - stokeLineWidth)).cgPath
        
        thumbLayer.strokeColor = strokeColor.cgColor
        thumbLayer.fillColor = trumbColor.cgColor
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
     //draw path
    fileprivate func backgroundPath(_ frame: CGRect) -> UIBezierPath {
        
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height), cornerRadius: frame.height/2)
        return rectanglePath
    }

}


