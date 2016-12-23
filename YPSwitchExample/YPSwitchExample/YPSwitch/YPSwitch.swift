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

enum YPSwitchResult<T>{
    
    case open(T)
    case close(T)
    
    @discardableResult
    func on(_ on:(_ value:T) -> Void) -> YPSwitchResult{
        switch self{
        case let .open(value):
            on(value)
        default:
            break
        }
        return self
    }
    
    @discardableResult
    func off(_ off:(_ value:T) -> Void) -> YPSwitchResult {
        switch self {
        case let .close(value):
            off(value)
        default:
            break
        }
        return self
    }
}


//TODO: - ViewModel
class YPSwitch:UIControl{
    
    //可以为回调添加关联值,T为关联值的类型
    typealias T = String
    
    //CompleteHandler
    var handler:((_ action:YPSwitchResult<T>)->())?
    
    //Layer collection
    open var animationLayer:(stokeLayer:CAShapeLayer,bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer)?
    
    //Switch动画时间
    open var animDuration = 0.5
    //边的宽度
    open var stokeLineWidth:CGFloat = 1
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
    
    open var animation:YPAnimation?
    var switchState: YPSwitchResult = .close("i an close")
    fileprivate var isOn:Bool = false
    fileprivate var isTap: Bool = false
    
    fileprivate var touchPoint:CGPoint!
    fileprivate var endPoint:CGPoint!

    init(position:CGPoint,size:CGSize = CGSize(width:60,height:35),type:YPSwitchType,_ hadler:@escaping (_ action:YPSwitchResult<T>)->()){
        
        super.init(frame:CGRect(origin: position, size: size))
        config(size,type)
        handler = hadler
    }
    
    init(position:CGPoint,size:CGSize = CGSize(width:60,height:35),type:YPSwitchType){
        super.init(frame:CGRect(origin: position, size: size))
        config(size,type)
    }
    
    func config(_ size:CGSize,_ type:YPSwitchType){
        backgroundColor = UIColor.clear
        animation = type.animation
        animation?.animationSize = size
        animation?.animDuration = animDuration
        self.buildLayer(size)
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
            endDrag()
        }
    }
    
    fileprivate func endDrag(){
        
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
    //回调
    private func callBack(){
        
        isOn = !isOn
        switchState = isOn == true ? .open("i an open") : .close("i an close")
        handler?(switchState)
        sendActions(for: UIControlEvents.valueChanged)
    }
    
}

//MARK: - 构造Layer  View层
extension YPSwitch{
    
    fileprivate func buildLayer(_ size:CGSize){
        
        //add layer with animation to the truple
        self.animationLayer = (stokeLayer:addStrokeBackgroundLayer(size),
                               bgLayer:  addBackgroundLayer(size),
                               thumbLayer:addThumbLayer(size))
    }
    
    private func addStrokeBackgroundLayer(_ size:CGSize) -> CAShapeLayer{
        
        let strokeBackgroundLayer = CAShapeLayer()
        strokeBackgroundLayer.path = backgroundPath(CGRect(x: 0,
                                                           y: 0,
                                                           width: size.width,
                                                           height:size.height)).cgPath
        strokeBackgroundLayer.strokeColor = strokeColor.cgColor
        strokeBackgroundLayer.fillColor = selectedColor.cgColor
        strokeBackgroundLayer.lineWidth = stokeLineWidth
        layer.addSublayer(strokeBackgroundLayer)
        return strokeBackgroundLayer
    }
    
    
    private func addBackgroundLayer(_ size:CGSize) -> CAShapeLayer{
        
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = backgroundPath(CGRect(x: stokeLineWidth/2,
                                                     y: stokeLineWidth/2,
                                                     width: size.width - stokeLineWidth,
                                                     height: size.height - stokeLineWidth)).cgPath
        backgroundLayer.fillColor = unselectedColor.cgColor
        layer.addSublayer(backgroundLayer)
        return backgroundLayer
    }
    
    private func addThumbLayer(_ size:CGSize) -> CAShapeLayer{
        
        let sizeH = size.height
        let diameter = sizeH - thumbInset - stokeLineWidth
        
        let thumbLayer = CAShapeLayer()
        thumbLayer.path = UIBezierPath(ovalIn: CGRect(x: thumbInset/2 + stokeLineWidth/2,
                                                      y: thumbInset/2 + stokeLineWidth/2,
                                                      width: diameter,
                                                      height: diameter)).cgPath
        
        thumbLayer.strokeColor = strokeColor.cgColor
        thumbLayer.fillColor = trumbColor.cgColor
        thumbLayer.lineWidth = 0.5
        thumbLayer.shadowColor = UIColor.black.cgColor
        thumbLayer.shadowOpacity = 0.3
        thumbLayer.shadowRadius = 1
        thumbLayer.shadowOffset = CGSize(width: 0, height: 2)
        
        layer.addSublayer(thumbLayer)
        return thumbLayer
    }
    
     //draw path
    fileprivate func backgroundPath(_ frame: CGRect) -> UIBezierPath {
        
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: frame.origin.x,
                                                             y: frame.origin.y,
                                                             width: frame.width, height: frame.height),
                                         cornerRadius: frame.height/2)
        return rectanglePath
    }

}


