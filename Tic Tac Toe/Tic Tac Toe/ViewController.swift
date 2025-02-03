//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Bruno Felalaga on 1/31/25.
//

import UIKit
//import InfoView

enum Player {
    case x
    case o
    case none
    
}
class ViewController: UIViewController {
    
    var previousInteractionState: Bool = true // ---------
    @IBOutlet var squares: [UIView]! //{
//        didSet {
//            print("Connected sss: \(squares.count)")
//            squares.forEach{ print("square tag: \($0.tag)")}
//        }
//    }
    
    @IBOutlet var xLabel: UILabel!
    @IBOutlet var oLabel: UILabel!
    @IBOutlet var infoView: InfoView!
    @IBOutlet var infoStyleButton: UIButton!
    
    private var currentPlayer:Player = .x
    private var startXCenter: CGPoint!
    private var startOCenter: CGPoint!
    private var activeLabel: UILabel?
    private let grid = Grid()
    private var pieceWidth: CGFloat!
    private var pieceFontSize: CGFloat!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieceWidth = xLabel.frame.width
        pieceFontSize = xLabel.font.pointSize
        setUpSquares()
        infoStyleButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoStyleButton.tintColor = .blue
        setupMyGestureRecognizers()
        saveStartingPositions()
        startNewGame()
//        infoView.dismissHandler = { [weak self] in
//            self?.startNewGame()}
        infoStyleButton.addTarget(self, action: #selector(showGameInstructions(_:)), for: .touchUpInside)
    }
    
    private func startNewGame() {
        grid.reset()
        currentPlayer = .x
        resetPieces()
        animateCurrentPlayerPiece()
        
    }
    
    private func saveStartingPositions() {
        startXCenter = xLabel.center
        startOCenter = oLabel.center
    }
    private func resetPieces() {
        // reset piece position
        xLabel.center = startXCenter
        oLabel.center = startOCenter
        
        //reset piece appearance
        xLabel.alpha = currentPlayer == .x ? 1.0 : 0.5
        oLabel.alpha = currentPlayer == .o ? 1.0 : 0.5
        
        // reset interaction
        xLabel.isUserInteractionEnabled = currentPlayer == .x
        oLabel.isUserInteractionEnabled = currentPlayer == .o
    }
    
    private func animateCurrentPlayerPiece() {
        let pieceToAnimate = currentPlayer == .x ? xLabel : oLabel
        
        UIView.animate(withDuration: 0.3, animations: {
            pieceToAnimate?.transform = CGAffineTransform(scaleX: 2.2, y: 2.2)
        }) { _ in
            UIView.animate(withDuration: 0.3){
                pieceToAnimate?.transform = .identity
            }}
    }
    
    private func setUpSquares() {
    //         Do any additional setup after loading the view.
            let lineWidth: Int = 5
//        let squareSize = 120
            if let myGridView = view.viewWithTag(100) {
                
//                print("rectGV x: \(myGridView.frame.origin.x) rectGV y: \(myGridView.frame.origin.y) ")
//                print("rectGV w: \(myGridView.frame.width) rectGV h: \(myGridView.frame.height) ")
                
                let squareSize = Int(myGridView.frame.width / 3)
                let gOX = Int(myGridView.frame.origin.x)
                let gOY = Int(myGridView.frame.origin.y)
    //            print("SQ SZ FROM GV: \(squareSize)")
                
                for i in 0..<9 {
                    let row = i / 3
                    let col = i % 3
                    squares[i].frame = CGRect(x: gOX + col * squareSize + (col > 0 ? lineWidth : 0),
                                              y: gOY + row * squareSize + (row > 0 ? lineWidth : 0),
                                              width: squareSize - (col > 0 ? lineWidth : 0),
                                              height: squareSize - (row > 0 ? lineWidth : 0))
                    
//                    print("sI: \(i) x: \(squares[i].frame.origin.x) y: \(squares[i].frame.origin.y)")
//                    print("sI: \(i) xi: \(squares[i].frame.origin.x + squares[i].frame.width) yi: \(squares[i].frame.origin.y + squares[i].frame.height)")
//                    print("")
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
        guard let panLabel = gesture.view as? UILabel else { return }
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .began:
            activeLabel = panLabel
        case .changed:
            panLabel.center = CGPoint(
                x: panLabel.center.x + translation.x,
                y: panLabel.center.y + translation.y )
            gesture.setTranslation(.zero, in: view)
        case .ended:
            checkForPlacementSquare(panLabel)
            activeLabel = nil
        
        default:
            break
        }
    }
    
//    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
//        guard let panLabel = gesture.view as? UILabel else { return }
//        let translation = gesture.translation(in: view)
//        
//        switch gesture.state {
//        case .began:
//            activeLabel = panLabel
//            let newPiece = createNewPiece(text: panLabel.text ?? "", at: panLabel == xLabel ? startXCenter : startOCenter)
//            newPiece.alpha = 0.5
//            panLabel == xLabel ? (xLabel = newPiece) : (oLabel = newPiece)
//            
//        case .changed:
//            panLabel.center = CGPoint(
//                x: panLabel.center.x + translation.x,
//                y: panLabel.center.y + translation.y )
//            gesture.setTranslation(.zero, in: view)
//            
//        case .ended:
//            if checkForPlacementSquare(panLabel) {
//                panLabel == xLabel ? xLabel.removeFromSuperview() : oLabel.removeFromSuperview()
//            } else {
//                panLabel.removeFromSuperview()
//                panLabel == xLabel ? (xLabel.alpha = 1.0) : (oLabel.alpha = 1.0)
//            }
//            activeLabel = nil
//            
//        default:
//            break
//        }
//    }
   
    
    private func checkForPlacementSquare(_ panLabel: UIView){ //} -> Bool{
        
        for (index, square) in squares.enumerated() {
//            print("ix \(index)")
            if panLabel.frame.intersects(square.frame) && grid.isSquareEmpty(at: index){
                print("dd \(index)")
                placePiece(panLabel, in: square, at: index)
                return
//                return true
            }
        }
        
        return returnPieceToStart(panLabel)
//        returnPieceToStart(panLabel)
//        return false
    }
    
//    private func placePiece(_ piece: UIView, in square: UIView, at index: Int ) {
//        piece.isUserInteractionEnabled = false
//        UIView.animate(withDuration: 0.2) {
//            piece.center = square.center
//        } completion: { _ in
////            piece.isUserInteractionEnabled = false
//            self.grid.markTheSquare(at: index, for: self.currentPlayer)
//            
//            if let winner = self.grid.checkWinner() {
//                self.handleWin(who: winner)
//            } else if self.grid.isATie() {
//                self.handleATie()
//            } else {
//                self.switchPlayerTurns()
//            }
//        }
//    }
//    
//    private func handleWin(who winner: Player) {
//        let message = winner == .x ? "X wins!" : "O wins!"
//        showGameOver(message: message)
//    }
    
    
    private func animateWinningLine(_ combination: [Int]) {
        let startSquare = squares[combination[0]]
        let endSquare = squares[combination[2]]
        
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = UIColor.purple.cgColor
        lineLayer.lineWidth = 5
        lineLayer.lineCap = .round
        
        let path = UIBezierPath()
        path.move(to: startSquare.center)
        path.addLine(to: endSquare.center)
        
        lineLayer.path = path.cgPath
        view.layer.addSublayer(lineLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        
        lineLayer.add(animation, forKey: "lineAnimation")
        
        // Remove line after delay and show game over
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            lineLayer.removeFromSuperlayer()
            self.showGameOver(message: self.currentPlayer == .x ? "X Wins!" : "O Wins!")
        }
    }

    // Replace your existing handleWin(who:) function with this:
    private func handleWin(who winner: Player) {
        guard let combination = grid.getWinningCombination() else { return }
        animateWinningLine(combination)
    }
    
//    private func switchPlayerTurns() {
//        currentPlayer = currentPlayer == .x ? .o : .x
//        resetPieces()
//        animateCurrentPlayerPiece()
//    }
//    
    
    private func handleATie() {
        showGameOver(message: "It is a Tie! Both won!")
    }
    
    private func returnPieceToStart(_ piece: UIView) {
        UIView.animate(withDuration: 0.3) {
            piece.center = piece == self.xLabel ? self.startXCenter : self.startOCenter
        }
    }
    private func showGameOver(message: String) {
        infoView.displayMessage(message)
        
        infoView.center.y = -infoView.bounds.height
        infoView.isHidden = false
        
//        view.window?.isUserInteractionEnabled = false  // Add this line
//        view.isUserInteractionEnabled = false
//        infoView.isUserInteractionEnabled = true // ---
        
        
        // Disable interactions
        squares.forEach { $0.isUserInteractionEnabled = false }
        xLabel.isUserInteractionEnabled = false
        oLabel.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.infoView.center.y = self.view.center.y
        }
        
    }
    
    
    @IBAction func showGameInstructionsXXX(_ sender: UIButton) {
//        previousInteractionState = view.isUserInteractionEnabled
        infoView.displayMessage("""
                                How to Play:
                                1. Drag X or O piece onto thegrid
                                2. Take turns placing pieces
                                3. Get 3 consectuive pieces in a row or column or diagonal and you win!
                                """, isLongMessage: true)
        
        infoView.center.y = -infoView.bounds.height // / 2
        infoView.isHidden = false
        
//        view.window?.isUserInteractionEnabled = false  // Add this line
//        view.isUserInteractionEnabled = false
//        infoView.isUserInteractionEnabled = true // ---
//        infoView.infoViewDismissButton.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.infoView.center.y = self.view.center.y
        }
    }
    
    @IBAction func showGameInstructions(_ sender: UIButton) {
        infoView.displayMessage("""
                                    How to Play:
                                    1. Drag X or O piece onto thegrid
                                    2. Take turns placing pieces
                                    3. Get 3 consectuive pieces in a row or column or diagonal and you win!
                                    """, isLongMessage: true)
        
        infoView.center.y = -infoView.bounds.height
        infoView.isHidden = false
        
        // Disable interactions
        squares.forEach { $0.isUserInteractionEnabled = false }
        xLabel.isUserInteractionEnabled = false
        oLabel.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.infoView.center.y = self.view.center.y
        }
    }
    
    
    
    
    
    
    
    
    
    private func placePiece(_ piece: UIView, in square: UIView, at index: Int) {
        UIView.animate(withDuration: 0.2) {
            piece.center = square.center
        } completion: { _ in
            // Update game state
            self.grid.markTheSquare(at: index, for: self.currentPlayer)
            piece.isUserInteractionEnabled = false
            
            // Check game end conditions
            if let winner = self.grid.checkWinner() {
                self.handleWin(who: winner)
            } else if self.grid.isATie() {
                self.handleATie()
            } else {
                print("cp: \(self.currentPlayer)")
                self.switchPlayerTurns()
            }
        }
    }

    private func switchPlayerTurns() {
        
        
        // Create and position new piece for next turn
        print("cp: \(currentPlayer)")
        if currentPlayer == .x {
            xLabel = createNewPiece(text: "X", at: startXCenter)
        } else {
            oLabel = createNewPiece(text: "O", at: startOCenter)
        }
        
        currentPlayer = currentPlayer == .x ? .o : .x
        
        // Set interaction states
        xLabel.isUserInteractionEnabled = currentPlayer == .x
        oLabel.isUserInteractionEnabled = currentPlayer == .o
        
        xLabel.alpha = currentPlayer == .x ? 1.0 : 0.5
        oLabel.alpha = currentPlayer == .o ? 1.0 : 0.5
        
        animateCurrentPlayerPiece()
    }

    
    private func createNewPiece(text: String, at center: CGPoint) -> UILabel {
        let newPiece = UILabel()
        newPiece.text = text
        newPiece.textAlignment = .center
        newPiece.font = .systemFont(ofSize: pieceFontSize, weight: .bold)
        newPiece.frame.size = CGSize(width: pieceWidth, height: pieceWidth) // Match original label size
        newPiece.center = center
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        newPiece.addGestureRecognizer(panGesture)
//        newPiece.isUserInteractionEnabled = true
        
        view.addSubview(newPiece)
        return newPiece
    }
    
}

