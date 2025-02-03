// //
// //  ViewController.swift
// //  Tic Tac Toe
// //
// //  Created by Bruno Felalaga on 1/31/25.
// //

// import UIKit

// class ViewController: UIViewController {
//     @IBOutlet var squares: [UIView]! {
//         didSet {
//             print("Connected sss: \(squares.count)")
//             squares.forEach{ print("square tag: \($0.tag)")}
//         }
//     }
    
//     @IBOutlet var xLabel: UILabel!
//     @IBOutlet var oLabel: UILabel!
    
    
//     let squareSize = 120
//     override func viewDidLoad() {
//         super.viewDidLoad()
// //         Do any additional setup after loading the view.
//         let lineWidth: Int = 5
//         if let myGridView = view.viewWithTag(100) {
//             let squareSize = Int(myGridView.frame.width / 3)
//             for i in 0..<9 {
//                 let row = i / 3
//                 let col = i % 3
//                 squares[i].frame = CGRect(x:col * squareSize + (col > 0 ? lineWidth : 0),
//                                           y: row * squareSize + (row > 0 ? lineWidth : 0),
//                                           width: squareSize - (col > 0 ? lineWidth : 0),
//                                           height: squareSize - (row > 0 ? lineWidth : 0))
                
//                 print("sI: \(i) x: \(squares[i].frame.origin.x) y: \(squares[i].frame.origin.y)")
//                 print("sI: \(i) xi: \(squares[i].frame.origin.x + squares[i].frame.width) yi: \(squares[i].frame.origin.y + squares[i].frame.height)")
//                 print("")
// //                print("sI: \(i) w: \(squares[i].frame.width) h: \(squares[i].frame.height)")
//             }
//         }
//     }
    
    
    
//     private func setupMyGestureRecognizers() {
//         xLabel.isUserInteractionEnabled = true
//         oLabel.isUserInteractionEnabled = true
        
//         let xPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
//         let oPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
//         xLabel.addGestureRecognizer(xPanGesture)
//         oLabel.addGestureRecognizer(oPanGesture)
        
//     }
    
//     @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
//         let panLabel = gesture.view!
//         let translation = gesture.translation(in: view)
        
//         switch gesture.state {
//         case .began, .changed:
//             panLabel.center = CGPoint(
//                 x: panLabel.center.x + translation.x,
//                 y: panLabel.center.y + translation.y )
//             gesture.setTranslation(.zero, in: view)
//         case .ended:
//             checkForPlacementSquare(panLabel)
        
//         default:
//             break
//         }
//     }
    
    
//     private func checkForPlacementSquare(_ panLabel: UIView) {
        
//     }


// }


import UIKit

enum Player {
    case x
    case o
}

class ViewController: UIViewController {
    @IBOutlet var squares: [UIView]!
    @IBOutlet private var xLabel: UILabel!
    @IBOutlet private var oLabel: UILabel!
    @IBOutlet private var infoView: InfoView!
    
    private let grid = Grid()
    private var currentPlayer: Player = .x
    private var originalXCenter: CGPoint!
    private var originalOCenter: CGPoint!
    private var activeLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSquares()
        setupGestureRecognizers()
        saveOriginalPositions()
        startNewGame()
    }
    
    private func setupSquares() {
        let lineWidth: Int = 5
        if let myGridView = view.viewWithTag(100) {
            let squareSize = Int(myGridView.frame.width / 3)
            for i in 0..<9 {
                let row = i / 3
                let col = i % 3
                squares[i].frame = CGRect(
                    x: col * squareSize + (col > 0 ? lineWidth : 0),
                    y: row * squareSize + (row > 0 ? lineWidth : 0),
                    width: squareSize - (col > 0 ? lineWidth : 0),
                    height: squareSize - (row > 0 ? lineWidth : 0)
                )
            }
        }
    }
    
    private func setupGestureRecognizers() {
        xLabel.isUserInteractionEnabled = true
        oLabel.isUserInteractionEnabled = true
        
        let xPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        let oPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
        xLabel.addGestureRecognizer(xPanGesture)
        oLabel.addGestureRecognizer(oPanGesture)
    }
    
    private func saveOriginalPositions() {
        originalXCenter = xLabel.center
        originalOCenter = oLabel.center
    }
    
    private func startNewGame() {
        grid.reset()
        currentPlayer = .x
        resetPieces()
        animateCurrentPlayerPiece()
    }
    
    private func resetPieces() {
        // Reset positions
        xLabel.center = originalXCenter
        oLabel.center = originalOCenter
        
        // Reset appearance
        xLabel.alpha = currentPlayer == .x ? 1.0 : 0.5
        oLabel.alpha = currentPlayer == .o ? 1.0 : 0.5
        
        // Reset interaction
        xLabel.isUserInteractionEnabled = currentPlayer == .x
        oLabel.isUserInteractionEnabled = currentPlayer == .o
    }
    
    private func animateCurrentPlayerPiece() {
        let pieceToAnimate = currentPlayer == .x ? xLabel : oLabel
        
        UIView.animate(withDuration: 0.3, animations: {
            pieceToAnimate?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                pieceToAnimate?.transform = .identity
            }
        }
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
                y: panLabel.center.y + translation.y
            )
            gesture.setTranslation(.zero, in: view)
            
        case .ended:
            checkForPlacement(panLabel)
            activeLabel = nil
            
        default:
            break
        }
    }
    
    private func checkForPlacement(_ panLabel: UILabel) {
        for (index, square) in squares.enumerated() {
            if panLabel.frame.intersects(square.frame) && grid.isSquareEmpty(at: index) {
                // Valid placement
                placePiece(panLabel, in: square, at: index)
                return
            }
        }
        
        // Invalid placement - return to start
        returnPieceToStart(panLabel)
    }
    
    private func placePiece(_ piece: UILabel, in square: UIView, at index: Int) {
        UIView.animate(withDuration: 0.2) {
            piece.center = square.center
        } completion: { _ in
            // Update model
            self.grid.markSquare(at: index, for: self.currentPlayer)
            
            // Check game state
            if let winner = self.grid.checkWinner() {
                self.handleWin(winner)
            } else if self.grid.isTie() {
                self.handleTie()
            } else {
                self.switchPlayers()
            }
        }
    }
    
    private func returnPieceToStart(_ piece: UILabel) {
        UIView.animate(withDuration: 0.3) {
            piece.center = piece == self.xLabel ? self.originalXCenter : self.originalOCenter
        }
    }
    
    private func switchPlayers() {
        currentPlayer = currentPlayer == .x ? .o : .x
        resetPieces()
        animateCurrentPlayerPiece()
    }
    
    private func handleWin(_ winner: Player) {
        let message = winner == .x ? "X Wins!" : "O Wins!"
        showGameOver(message: message)
    }
    
    private func handleTie() {
        showGameOver(message: "It's a Tie!")
    }
    
    private func showGameOver(message: String) {
        infoView.setMessage(message)
        
        // Animate info view from top
        infoView.center.y = -infoView.bounds.height
        infoView.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.infoView.center.y = self.view.center.y
        }
    }
    
    @IBAction func showInstructions(_ sender: UIButton) {
        infoView.setMessage("""
            How to Play:
            1. Drag X or O pieces onto the grid
            2. Take turns placing pieces
            3. Get 3 in a row to win!
            """)
        
        // Show info view with instructions
        infoView.center.y = -infoView.bounds.height
        infoView.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.infoView.center.y = self.view.center.y
        }
    }
}


// Add to ViewController.swift

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
    
    // Remove line after delay
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        lineLayer.removeFromSuperlayer()
        self.showGameOver(message: self.currentPlayer == .x ? "X Wins!" : "O Wins!")
    }
}

// Modify handleWin function:
private func handleWin(_ winner: Player) {
    if let combination = grid.getWinningCombination() {
        animateWinningLine(combination)
    } else {
        let message = winner == .x ? "X Wins!" : "O Wins!"
        showGameOver(message: message)
    }
}




class Grid {
    // gridView.frame = CGRect(x: x, y: y, width: width, height: height)
    private var squares: [Player] = Array(repeating: .none, count: 9)
    private let winningCombinations = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],  // Rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8],  // Columns
        [0, 4, 8], [2, 4, 6]              // Diagonals
    ]
    
    func isSquareEmpty(at index: Int) -> Bool {
        return squares[index] == .none
    }
    
    func markSquare(at index: Int, for player: Player) {
        squares[index] = player
    }
    
    func checkWinner() -> Player? {
        for combination in winningCombinations {
            let first = squares[combination[0]]
            let second = squares[combination[1]]
            let third = squares[combination[2]]
            
            if first != .none && first == second && second == third {
                return first
            }
        }
        return nil
    }
    
    func getWinningCombination() -> [Int]? {
        for combination in winningCombinations {
            let first = squares[combination[0]]
            let second = squares[combination[1]]
            let third = squares[combination[2]]
            
            if first != .none && first == second && second == third {
                return combination
            }
        }
        return nil
    }
    
    func isTie() -> Bool {
        return !squares.contains(.none) && checkWinner() == nil
    }
    
    func reset() {
        squares = Array(repeating: .none, count: 9)
    }
}

