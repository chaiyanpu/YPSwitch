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
            return YPSpringAnimation()
        case .switchThree:
            return YPBounceAnimation()
        case .switchFour:
            return YPRotationAnimaiton()
        }
    }
}

enum YPSwitchResult{
    
    case open
    case close
    
    @discardableResult
    func on(_ on:() -> Void) -> YPSwitchResult{
        switch self{
        case  .open:
            on()
        default:
            break
        }
        return self
    }
    
    @discardableResult
    func off(_ off:() -> Void) -> YPSwitchResult {
        switch self {
        case .close:
            off()
        default:
            break
        }
        return self
    }
}
typealias SwitchState = YPSwitchResult

class YPSwitch:UIControl{
    
    //CompleteHandler
    var handler:((_ action:YPSwitchResult)->())?
    
    //Layer collection
    open var animationLayer:(stokeLayer:CAShapeLayer,bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer)?
    
    open var switchLayer:YPSwitchLayer?
    open var animation:YPAnimation?
    var switchState: YPSwitchResult = .close
    
    fileprivate var isOn:Bool = false
    fileprivate var isTap: Bool = false
    fileprivate var touchPoint:CGPoint!
    fileprivate var endPoint:CGPoint!

    //TODO:根据State创建Layer.
    init(position:CGPoint,size:CGSize = CGSize(width:50,height:25),state:SwitchState = .close,type:YPSwitchType = .switchOne,_ hadler:@escaping (_ action:YPSwitchResult)->()){
        
        super.init(frame:CGRect(origin: position, size: size))
        config(size,state,type)
        handler = hadler
    }
    
    init(position:CGPoint,size:CGSize = CGSize(width:50,height:25),state:SwitchState = .close,type:YPSwitchType = .switchOne){
        super.init(frame:CGRect(origin: position, size: size))
        config(size,state,type)
    }
    
    func config(_ size:CGSize,_ state:SwitchState,_ type:YPSwitchType){
        backgroundColor = UIColor.clear

        switchState = state
        animation = type.animation
        animation?.animationSize = size
        animation?.animDuration = YPSwitchConfig.animDuration
        
        self.switchLayer = YPSwitchLayer(size)
        guard self.switchLayer != nil else {
            fatalError("SwitchLayer is nil")
        }
        layer.addSublayer(switchLayer!)
        animationLayer = (stokeLayer:switchLayer!.stokeLayer,
                          bgLayer:switchLayer!.backgroundLayer,
                          thumbLayer:switchLayer!.thumbLayer)

    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}

class YPSwitchLayer:CAShapeLayer{
    
    var state = 1
    
    var size:CGSize = CGSize()
    var sizeH:CGFloat{return size.height}
    var diameter:CGFloat{return (sizeH - YPSwitchConfig.thumbInset - YPSwitchConfig.stokeLineWidth)}
    
    init(_ size:CGSize) {
        super.init()
        self.size = size
        
        addStrokeBackgroundLayer()
        addBGLayer()
        addThumbLayer()
    }
    
    //thumbLayer
    func addThumbLayer(){
        thumbLayer.path = thumbClosePath.cgPath
        thumbLayer.strokeColor = YPSwitchConfig.strokeColor.cgColor
        thumbLayer.fillColor = YPSwitchConfig.trumbColor.cgColor
        thumbLayer.lineWidth = 0.5
        thumbLayer.shadowColor = UIColor.black.cgColor
        thumbLayer.shadowOpacity = 0.3
        thumbLayer.shadowRadius = 1
        thumbLayer.shadowOffset = CGSize(width: 0, height: 2)
        addSublayer(thumbLayer)
    }
    
    let thumbLayer:CAShapeLayer = CAShapeLayer()
    var inset:CGFloat{return YPSwitchConfig.thumbInset/2 + YPSwitchConfig.stokeLineWidth/2}
    var thumbX:CGFloat{return state == 1 ? inset : self.frame.width - diameter - inset}
    var thumbClosePath:UIBezierPath{return UIBezierPath(ovalIn: CGRect(x: thumbX,
                                                                       y: inset,
                                                                       width: diameter,
                                                                       height: diameter))}
    
    var thumbOpenPath:UIBezierPath{return UIBezierPath(ovalIn: CGRect(x: inset,
                                                                      y: inset,
                                                                      width: diameter,
                                                                      height: diameter))}
    
    //bgLayer
    func addBGLayer(){
        backgroundLayer.path = bgClosePath.cgPath
        backgroundLayer.fillColor = YPSwitchConfig.unselectedColor.cgColor
        addSublayer(backgroundLayer)
    }
    
    var bgClosePath:UIBezierPath{
        return UIBezierPath(roundedRect:CGRect(x: YPSwitchConfig.stokeLineWidth/2,
                                                y: YPSwitchConfig.stokeLineWidth/2,
                                                width: size.width - YPSwitchConfig.stokeLineWidth, height: size.height - YPSwitchConfig.stokeLineWidth),
                            cornerRadius: size.height/2)
    }
    
    var bgOpenPath:UIBezierPath{
        return UIBezierPath(ovalIn: CGRect(x: size.width/2,
                                           y: size.height/2,
                                           width: 0,
                                           height: 0))
    }

    let backgroundLayer:CAShapeLayer = CAShapeLayer()
    
    //stokeLayer
    let stokeLayer:CAShapeLayer = CAShapeLayer()
    func addStrokeBackgroundLayer(){
        stokeLayer.path = bgStokeClosePath.cgPath
        stokeLayer.strokeColor = YPSwitchConfig.strokeColor.cgColor
        stokeLayer.fillColor = YPSwitchConfig.selectedColor.cgColor
        stokeLayer.lineWidth = YPSwitchConfig.stokeLineWidth
        addSublayer(stokeLayer)
    }
    var bgStokeClosePath:UIBezierPath{
        return UIBezierPath(roundedRect: CGRect(x: YPSwitchConfig.stokeLineWidth/2,
                                                y: YPSwitchConfig.stokeLineWidth/2,
                                                width: size.width - YPSwitchConfig.stokeLineWidth, height: size.height - YPSwitchConfig.stokeLineWidth),
                            cornerRadius: size.height/2)
    }
    var bgStokeOpenPath:UIBezierPath{
        return bgStokeClosePath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//事物处理
extension YPSwitch{
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
                animation?.playAnimation(animationLayer: animationLayer, to:.close)
            }else{
                animation?.playAnimation(animationLayer: animationLayer, to:.open)
            }
            
            callBack()
        case false:
            endDrag()
        }
    }
    
    fileprivate func endDrag(){
        
        switch isOn {
        case true:
            if touchPoint.x - endPoint.x - self.frame.size.width/3  > 0{
                animation?.playAnimation(animationLayer: animationLayer, to: .close)
                callBack()
            }
        case false:
            if endPoint.x - touchPoint.x - self.frame.size.width/3 > 0{
                animation?.playAnimation(animationLayer: animationLayer, to: .open)
                callBack()
            }
        }
    }
    
    //回调
    private func callBack(){
        
        isOn = !isOn
        switchState = isOn == true ? .open : .close
        handler?(switchState)
        sendActions(for: UIControlEvents.valueChanged)
    }

}

class YPSwitchConfig{
    
    //灰色边
    open static let strokeColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    //选中的边
    open static let selectedStokeColor = #colorLiteral(red: 0.4352941176, green: 0.8470588235, blue: 0.3921568627, alpha: 1)
    //未选中背景颜色
    open static let unselectedColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //选中背景
    open static let selectedColor = #colorLiteral(red: 0.4352941176, green: 0.8470588235, blue: 0.3921568627, alpha: 1)
    //滑块颜色
    open static let trumbColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    //Switch动画时间
    open static let animDuration = 0.5
    //边的宽度
    open static let stokeLineWidth:CGFloat = 1
    //thumb离边的距离
    open static let thumbInset:CGFloat = 1
    
}



