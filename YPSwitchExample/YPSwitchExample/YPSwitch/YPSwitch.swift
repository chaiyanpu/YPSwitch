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

//TODO: - ViewModel
class YPSwitch:UIControl{
    
    //灰色边
    open var strokeColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    //选中的边
    open var selectedStokeColor = #colorLiteral(red: 0.4352941176, green: 0.8470588235, blue: 0.3921568627, alpha: 1)
    //未选中背景颜色
    open var unselectedColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //选中背景
    open var selectedColor = #colorLiteral(red: 0.4352941176, green: 0.8470588235, blue: 0.3921568627, alpha: 1)
    //滑块颜色
    open var trumbColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
    //CompleteHandler
    var handler:((_ action:YPSwitchResult)->())?
    
    //Layer collection
    open var animationLayer:(stokeLayer:CAShapeLayer,bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer)?
    
    //Switch动画时间
    open var animDuration = 0.5
    //边的宽度
    open var stokeLineWidth:CGFloat = 1
    //thumb离边的距离
    open var thumbInset : CGFloat = 1
    
    open var animation:YPAnimation?
    var switchState: YPSwitchResult = .close
    
    fileprivate var isOn:Bool = false
    fileprivate var isTap: Bool = false
    fileprivate var touchPoint:CGPoint!
    fileprivate var endPoint:CGPoint!

    //TODO:根据State创建Layer.
    init(position:CGPoint,size:CGSize = CGSize(width:60,height:35),state:SwitchState = .close,type:YPSwitchType = .switchOne,_ hadler:@escaping (_ action:YPSwitchResult)->()){
        
        super.init(frame:CGRect(origin: position, size: size))
        config(size,state,type)
        handler = hadler
    }
    
    init(position:CGPoint,size:CGSize = CGSize(width:60,height:35),state:SwitchState = .close,type:YPSwitchType = .switchOne){
        super.init(frame:CGRect(origin: position, size: size))
        config(size,state,type)
    }
    
    func config(_ size:CGSize,_ state:SwitchState,_ type:YPSwitchType){
        backgroundColor = UIColor.clear
        switchState = state
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
    
    var openStateLayer:CALayer!
    var coseStateLayer:CALayer!
    
}

//MARK: - 构造Layer  View层
extension YPSwitch{
    
    //template
    func value<T>(_ state:SwitchState,onValue:T,offValue:T) -> T{
        return state == .open ? onValue : offValue
    }
    
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
            //value(switchState, onValue: self.strokeColor, offValue: selectedStokeColor).cgColor
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


class TempLayer:CALayer{
    
    var state = 1
    
    let size:CGSize = CGSize(width: 100, height: 100)
    var sizeH:CGFloat{return size.height}
    var diameter:CGFloat{return (sizeH - thumbInset - stokeLineWidth)}
    
    override init() {
        super.init()
        addThumbLayer()
    }
    
    //thumbLayer
    func addThumbLayer(){
        thumbLayer.path = thumbClosePath.cgPath
        thumbLayer.strokeColor = strokeColor.cgColor
        thumbLayer.fillColor = trumbColor.cgColor
        thumbLayer.lineWidth = 0.5
        thumbLayer.shadowColor = UIColor.black.cgColor
        thumbLayer.shadowOpacity = 0.3
        thumbLayer.shadowRadius = 1
        thumbLayer.shadowOffset = CGSize(width: 0, height: 2)
        self.addSublayer(thumbLayer)
    }
    
    let thumbLayer:CAShapeLayer = CAShapeLayer()
    var inset:CGFloat{return thumbInset/2 + stokeLineWidth/2}
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
        backgroundLayer.fillColor = bgUnselectedColor.cgColor
        self.addSublayer(backgroundLayer)
    }
    
    var bgClosePath:UIBezierPath{
        return UIBezierPath(roundedRect: CGRect(x: stokeLineWidth/2,
                                                y: stokeLineWidth/2,
                                                width: size.width - stokeLineWidth, height: size.height - stokeLineWidth),
                            cornerRadius: size.height/2)
    }
    var bgOpenPath:UIBezierPath{
        return UIBezierPath(ovalIn: CGRect(x: size.width/2,
                                           y: size.height/2,
                                           width: 0,
                                           height: 0))
    }
    var bgUnselectedColor:UIColor{return unselectedColor}
    var bgSelectedColor:UIColor{return selectedStokeColor}
    let backgroundLayer:CAShapeLayer = CAShapeLayer()
    
    
    //stokeLayer
    let stokeLayer:CAShapeLayer = CAShapeLayer()
    func addStrokeBackgroundLayer(){
        stokeLayer.path = bgStokeClosePath.cgPath
        stokeLayer.strokeColor = stokeLayerStokeColor.cgColor
        stokeLayer.fillColor = stokeLayerFillColor.cgColor
        stokeLayer.lineWidth = stokeLayerLineWitch
        self.addSublayer(stokeLayer)
    }
    var bgStokeClosePath:UIBezierPath{
        return UIBezierPath(roundedRect: CGRect(x: stokeLineWidth/2,
                                                y: stokeLineWidth/2,
                                                width: size.width - stokeLineWidth, height: size.height - stokeLineWidth),
                            cornerRadius: size.height/2)
    }
    var bgStokeOpenPath:UIBezierPath{
        return bgStokeClosePath
    }
    
    var stokeLayerStokeColor:UIColor{return strokeColor}
    var stokeLayerLineWitch:CGFloat{return stokeLineWidth}
    var stokeLayerFillColor:UIColor{return selectedColor}
    
    //灰色边
    open var strokeColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    //选中的边
    open var selectedStokeColor = #colorLiteral(red: 0.4352941176, green: 0.8470588235, blue: 0.3921568627, alpha: 1)
    //未选中背景颜色
    open var unselectedColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //选中背景
    open var selectedColor = #colorLiteral(red: 0.4352941176, green: 0.8470588235, blue: 0.3921568627, alpha: 1)
    //滑块颜色
    open var trumbColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    
    //CompleteHandler
    var handler:((_ action:YPSwitchResult)->())?
    
    //Layer collection
    open var animationLayer:(stokeLayer:CAShapeLayer,bgLayer: CAShapeLayer, thumbLayer: CAShapeLayer)?
    
    //Switch动画时间
    open var animDuration = 0.5
    //边的宽度
    open var stokeLineWidth:CGFloat = 1
    //thumb离边的距离
    open var thumbInset:CGFloat = 1

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




