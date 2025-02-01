//
//  GridView.swift
//  Tic Tac Toe
//
//  Created by Bruno Felalaga on 1/31/25.
//

import UIKit


@IBDesignable
public class GridView: UIView {
    
    @IBInspectable var lineWidth: CGFloat = 2.0
    
    public override func draw(_ rect: CGRect) {
        
        let verticalLine = UIBezierPath()
        let leftLineX = rect.width / 3
        let rightLineX = leftLineX * 2
        
        verticalLine.move(to: CGPoint(x: leftLineX, y: 0))
        verticalLine.addLine(to: CGPoint(x: leftLineX, y: rect.height))
        
        verticalLine.move(to: CGPoint(x: rightLineX, y: 0))
        verticalLine.addLine(to: CGPoint(x: rightLineX, y: rect.height))
        
        
        let horizontalLine = UIBezierPath()
        let topLineY = rect.height / 3
        let bottomLineY = topLineY * 2
        
        horizontalLine.move(to: CGPoint(x: 0, y: topLineY))
        horizontalLine.addLine(to: CGPoint(x: rect.width, y: topLineY))
        
        horizontalLine.move(to: CGPoint(x: 0, y: bottomLineY))
        horizontalLine.addLine(to: CGPoint(x: rect.width, y: bottomLineY))
        
        
        UIColor.purple.setStroke()
        verticalLine.lineWidth = lineWidth //5.0
        horizontalLine.lineWidth = lineWidth //5.0
        
        verticalLine.stroke()
        horizontalLine.stroke()
        
        print("rect w: \(rect.width) rect h: \(rect.height) ")
        print("lx: \(leftLineX) rx: \(rightLineX)")
        print("tY: \(topLineY) bY: \(bottomLineY)")
        
//        rect w: 370.0 rect h: 532.0
//        lx: 123.33333333333333 rx: 246.66666666666666
//        tY: 177.33333333333334 bY: 354.6666666666667
    }
}
