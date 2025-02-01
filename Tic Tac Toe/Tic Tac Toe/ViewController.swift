//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Bruno Felalaga on 1/31/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var squares: [UIView]! {
        didSet {
            print("Connected sss: \(squares.count)")
            squares.forEach{ print("square tag: \($0.tag)")}
        }
    }
    
    @IBOutlet var xLabel: UILabel!
    @IBOutlet var oLabel: UILabel!
    
    
    let squareSize = 120
    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view.
        let lineWidth: Int = 5
        if let myGridView = view.viewWithTag(100) {
            let squareSize = Int(myGridView.frame.width / 3)
            for i in 0..<9 {
                let row = i / 3
                let col = i % 3
                squares[i].frame = CGRect(x:col * squareSize + (col > 0 ? lineWidth : 0),
                                          y: row * squareSize + (row > 0 ? lineWidth : 0),
                                          width: squareSize - (col > 0 ? lineWidth : 0),
                                          height: squareSize - (row > 0 ? lineWidth : 0))
                
                print("sI: \(i) x: \(squares[i].frame.origin.x) y: \(squares[i].frame.origin.y)")
                print("sI: \(i) xi: \(squares[i].frame.origin.x + squares[i].frame.width) yi: \(squares[i].frame.origin.y + squares[i].frame.height)")
                print("")
//                print("sI: \(i) w: \(squares[i].frame.width) h: \(squares[i].frame.height)")
            }
        }
    }
    
    
    
    private func setupMyGestureRecognizers() {
        xLabel.isUserInteractionEnabled = true
        oLabel.isUserInteractionEnabled = true
        
        let xPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        let oPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
        xLabel.addGestureRecognizer(xPanGesture)
        oLabel.addGestureRecognizer(oPanGesture)
        
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let panLabel = gesture.view!
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .began, .changed:
            panLabel.center = CGPoint(
                x: panLabel.center.x + translation.x,
                y: panLabel.center.y + translation.y )
            gesture.setTranslation(.zero, in: view)
        case .ended:
            checkForPlacementSquare(panLabel)
        
        default:
            break
        }
    }
    
    
    private func checkForPlacementSquare(_ panLabel: UIView) {
        
    }


}

