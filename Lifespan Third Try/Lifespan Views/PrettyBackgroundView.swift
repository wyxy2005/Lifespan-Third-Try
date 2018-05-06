//
//  BarView.swift
//  Lifeclock
//
//  Created by John Pavley on 2/17/18.
//  Copyright © 2018 Epic Loot. All rights reserved.
//

import UIKit

// TODO: Change background color based on LifeClock time.
//       From light to dark. 12 o'clock is lightest.
//       6 o'clock is darkest.

@IBDesignable
class PrettyBackgroundView: UIView {
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let p = UIBezierPath()
        
        // top line
        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: frame.width, y: 0))
        
        // bottom line
        p.move(to: CGPoint(x: 0, y: frame.height))
        p.addLine(to: CGPoint(x: frame.width, y: frame.height))

        
        p.close()
        UIColor.gray.set()
        p.stroke()
    }
}
