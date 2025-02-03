//
//  GridView.swift
//  Tic Tac Toe
//
//  Created by Bruno Felalaga on 1/31/25.
//

import UIKit

@IBDesignable
// Class draws tic tac toe grid with vertical and horizontal lines
public class GridView: UIView {
    
    @IBInspectable var lineWidth: CGFloat = 2.0

    
    public override func draw(_ rect: CGRect) {

        // Create vertical grid lines
        let verticalLine = UIBezierPath()
        let leftLineX = rect.width / 3
        let rightLineX = leftLineX * 2
        
        // add line between line points for both 
        verticalLine.move(to: CGPoint(x: leftLineX, y: 0))
        verticalLine.addLine(to: CGPoint(x: leftLineX, y: rect.height))
        
        verticalLine.move(to: CGPoint(x: rightLineX, y: 0))
        verticalLine.addLine(to: CGPoint(x: rightLineX, y: rect.height))
        
        // Create horizontal grid lines
        let horizontalLine = UIBezierPath()
        let topLineY = rect.height / 3
        let bottomLineY = topLineY * 2
        
        // add line between line points for both 
        horizontalLine.move(to: CGPoint(x: 0, y: topLineY))
        horizontalLine.addLine(to: CGPoint(x: rect.width, y: topLineY))
        
        horizontalLine.move(to: CGPoint(x: 0, y: bottomLineY))
        horizontalLine.addLine(to: CGPoint(x: rect.width, y: bottomLineY))
        
        // Set stroke color and apply line width.
        //  Then draw the grid lines.
        UIColor.purple.setStroke()
        verticalLine.lineWidth = lineWidth 
        horizontalLine.lineWidth = lineWidth 
        
        verticalLine.stroke()
        horizontalLine.stroke()
        
    }
}
