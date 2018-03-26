//
//  HourHandView.swift
//  Lifespan 2018
//
//  Created by John Pavley on 2/22/18.
//  Copyright © 2018 jpavley12. All rights reserved.
//

import UIKit

class HourHandView: CoreGraphicsView {
    
    let hourHandPathRef = CGMutablePath()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        drawHourHand()
        self.transform = CGAffineTransform(rotationAngle: CGFloat(angle).degreesToRadians)

    }
    
    /// Code generated by Graphics.app.
    private func drawHourHand() {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        // enable the following lines for flipped coordinate systems
        // ctx.translateBy(x: 0, y: self.bounds.size.height)
        // ctx.scaleBy(x: 1, y: -1)
        
        let scaleFactor: CGFloat = calcScaleFactor(viewWidth: self.bounds.width)
        ctx.scaleBy(x: scaleFactor, y: scaleFactor)
        
        /*  Shape   */
        hourHandPathRef.move(to: CGPoint(x: 308.028, y: 367.873))
        hourHandPathRef.addCurve(to: CGPoint(x: 308.028, y: 329.796), control1: CGPoint(x: 308.028, y: 367.873), control2: CGPoint(x: 308.028, y: 329.796))
        hourHandPathRef.addCurve(to: CGPoint(x: 316.009, y: 323.45), control1: CGPoint(x: 308.028, y: 329.796), control2: CGPoint(x: 316.009, y: 323.45))
        hourHandPathRef.addCurve(to: CGPoint(x: 316.009, y: 317.104), control1: CGPoint(x: 316.009, y: 323.45), control2: CGPoint(x: 316.009, y: 317.104))
        hourHandPathRef.addCurve(to: CGPoint(x: 308.028, y: 310.758), control1: CGPoint(x: 316.009, y: 317.104), control2: CGPoint(x: 308.028, y: 310.758))
        hourHandPathRef.addCurve(to: CGPoint(x: 316.009, y: 196.526), control1: CGPoint(x: 308.028, y: 310.758), control2: CGPoint(x: 316.009, y: 196.526))
        hourHandPathRef.addCurve(to: CGPoint(x: 323.991, y: 196.526), control1: CGPoint(x: 316.009, y: 196.526), control2: CGPoint(x: 323.991, y: 196.526))
        hourHandPathRef.addCurve(to: CGPoint(x: 331.972, y: 310.758), control1: CGPoint(x: 323.991, y: 196.526), control2: CGPoint(x: 331.972, y: 310.758))
        hourHandPathRef.addCurve(to: CGPoint(x: 323.991, y: 317.104), control1: CGPoint(x: 331.972, y: 310.758), control2: CGPoint(x: 323.991, y: 317.104))
        hourHandPathRef.addCurve(to: CGPoint(x: 323.991, y: 323.45), control1: CGPoint(x: 323.991, y: 317.104), control2: CGPoint(x: 323.991, y: 323.45))
        hourHandPathRef.addCurve(to: CGPoint(x: 331.972, y: 329.796), control1: CGPoint(x: 323.991, y: 323.45), control2: CGPoint(x: 331.972, y: 329.796))
        hourHandPathRef.addCurve(to: CGPoint(x: 331.972, y: 367.873), control1: CGPoint(x: 331.972, y: 329.796), control2: CGPoint(x: 331.972, y: 367.873))
        hourHandPathRef.addCurve(to: CGPoint(x: 308.028, y: 367.873), control1: CGPoint(x: 331.972, y: 367.873), control2: CGPoint(x: 308.028, y: 367.873))
        hourHandPathRef.closeSubpath()
        
        ctx.setFillColor(red: 0.004, green: 0.259, blue: 0.949, alpha: 1)
        ctx.addPath(hourHandPathRef)
        ctx.fillPath()
        
    }
}
