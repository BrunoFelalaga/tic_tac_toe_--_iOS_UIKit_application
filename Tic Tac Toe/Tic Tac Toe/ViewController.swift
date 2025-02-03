//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Bruno Felalaga on 1/31/25.
//


import UIKit

enum Player {
    case x
    case o
    case none
    
}
class ViewController: UIViewController {
    
    @IBOutlet var squares: [UIView]! 
    
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
        // configureInitialPieceProperties()
        // setUpSquares()
        // configureInfoButton() 
        // setup squares, gesture recognizers and save starting piece positions
        
        configureGameSetup()
        startNewGame()
        // infoStyleButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        // infoStyleButton.tintColor = .blue
        // infoStyleButton.addTarget(self, action: #selector(showGameInstructions(_:)), for: .touchUpInside) // Set up tap action for the info button
    }

    // Set up all configs before starting new game
    private func configureGameSetup() {
        setupMyGestureRecognizers()
        saveStartingPositions()
        configureInitialPieceProperties()
        setUpSquares()
        configureInfoButton()
    }

    private func configureInitialPieceProperties() {
        pieceWidth = xLabel.frame.width
        pieceFontSize = xLabel.font.pointSize
    }

    private func configureInfoButton() {
        infoStyleButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoStyleButton.tintColor = .blue
        infoStyleButton.addTarget(
            self,
            action: #selector(showGameInstructions(_:)),
            for: .touchUpInside
        )
    }

    // Start a new game by resetting the grid, 
    // setting the current player to X, resetting pieces, and animating the first move.
    private func startNewGame() {
        grid.reset() // Clear the game grid
        currentPlayer = .x
        resetPieces() // Reset X and O piece positions and interactions
        animateCurrentPlayerPiece() // Animate the current player's piece
        
    }
    
    // Save the initial center positions of X and O labels for resetting later.
    private func saveStartingPositions() {
        startXCenter = xLabel.center
        startOCenter = oLabel.center
    }

    // Reset the positions, appearance, and interaction of X and O pieces at the start of each turn.
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
    
    // Animate the current player's piece by briefly enlarging it and then returning it to normal size.
    private func animateCurrentPlayerPiece() {
        let pieceToAnimate = currentPlayer == .x ? xLabel : oLabel
        
        // First enlarge the piece to highlight the active player.
        
        UIView.animate(withDuration: 0.3, animations: {
            pieceToAnimate?.transform = CGAffineTransform(scaleX: 2.2, y: 2.2)
        }) { _ in
            UIView.animate(withDuration: 0.3){ //  Second restore it to normal size.
                pieceToAnimate?.transform = .identity
            }}
    }
    
    // Set up the tic-tac-toe grid squares
    private func setUpSquares() {
            let lineWidth: Int = 5 // Gap between squares

            // get grid by tag. This was set 100 so we can find it in view controller class
            if let myGridView = view.viewWithTag(100) {
                
                // square size by grid width
                let squareSize = Int(myGridView.frame.width / 3)

                // grid X na Y origins
                let gOX = Int(myGridView.frame.origin.x)
                let gOY = Int(myGridView.frame.origin.y)
                
                
                for i in 0..<9 { // Place all 9 squares on 3X3 layout
                    let row = i / 3
                    let col = i % 3
                    // Set positions such that the grid lines(lineWidth) are visible
                    squares[i].frame = CGRect(x: gOX + col * squareSize + (col > 0 ? lineWidth : 0),
                                              y: gOY + row * squareSize + (row > 0 ? lineWidth : 0),
                                              width: squareSize - (col > 0 ? lineWidth : 0),
                                              height: squareSize - (row > 0 ? lineWidth : 0))
                    
                }
            }
    }
    
    
    // Set up gesture recognizers for dragging X and O pieces.
    private func setupMyGestureRecognizers() {
        // enable user interaction for both labels
        xLabel.isUserInteractionEnabled = true
        oLabel.isUserInteractionEnabled = true
        
        // create the pan gesture recognizers for both labels
        let xPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        let oPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
        // now add the respective pangesturerecognizers tot he labels
        xLabel.addGestureRecognizer(xPanGesture)
        oLabel.addGestureRecognizer(oPanGesture)
        
    }
    
    // Handle the dragging (pan gesture) of X and O pieces.
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let panLabel = gesture.view as? UILabel else { return }
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .began:
            activeLabel = panLabel // Track active piece
        case .changed: // Move the piece based on the gesture's movement and Reset translation to avoid cumulative offsets.
            panLabel.center = CGPoint(
                x: panLabel.center.x + translation.x,
                y: panLabel.center.y + translation.y )
            gesture.setTranslation(.zero, in: view) // Reset translation
        case .ended:
            checkForPlacementSquare(panLabel)  // Check if piece is placed in a valid square
            activeLabel = nil // Clear active piece
        
        default: // break for default
            break
        }
    }
    
    // Check if the dragged piece is placed over a valid empty square and place pice if empty
    private func checkForPlacementSquare(_ panLabel: UIView){ 
        
        for (index, square) in squares.enumerated() { // find which square is intersecting and empty
            if panLabel.frame.intersects(square.frame) && grid.isSquareEmpty(at: index){
              
                placePiece(panLabel, in: square, at: index)
                return
            }
        }
        
        return returnPieceToStart(panLabel) // Return piece if no valid placement
    }
    
    // Animates a winning line across the three matching squares.
    private func animateWinningLine(_ combination: [Int]) {
        // starting and ending winnning combination
        let startSquare = squares[combination[0]]
        let endSquare = squares[combination[2]]
        
        // / Create and configure the line layer
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = UIColor.purple.cgColor
        lineLayer.lineWidth = 5
        lineLayer.lineCap = .round
        
        // Define the path for the winning line
        let path = UIBezierPath()
        path.move(to: startSquare.center)
        path.addLine(to: endSquare.center)
        
        lineLayer.path = path.cgPath
        view.layer.addSublayer(lineLayer)
        
        // Animate the drawing of the line
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        
        lineLayer.add(animation, forKey: "lineAnimation")
        
        // Remove the winning line after a delay and display the game over message.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            lineLayer.removeFromSuperlayer()
            self.showGameOver(message: self.currentPlayer == .x ? "X Wins!" : "O Wins!")
        }
    }

    // Handle a win by retrieving the winning combination and animating the winning line.
    private func handleWin(who winner: Player) {
        guard let combination = grid.getWinningCombination() else { return }
        animateWinningLine(combination)
    }
    
    // Handle a tie situation
    private func handleATie() {
        showGameOver(message: "It is a Tie! Both won!")
    }
    
    // return piece to starting position if no valid square found for placement
    private func returnPieceToStart(_ piece: UIView) {
        UIView.animate(withDuration: 0.3) { // animate the return briefly
            piece.center = piece == self.xLabel ? self.startXCenter : self.startOCenter
        }
    }

    // Display the game-over message and disables interactions.
    private func showGameOver(message: String) {
        infoView.displayMessage(message)
        
        // Position off-screen and amke visible
        infoView.center.y = -infoView.bounds.height
        infoView.isHidden = false
        
        // Disable interactions
        squares.forEach { $0.isUserInteractionEnabled = false }
        xLabel.isUserInteractionEnabled = false
        oLabel.isUserInteractionEnabled = false
        
        // Animate the info view sliding into the center.
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.infoView.center.y = self.view.center.y
        }
        
    }
    
    
    @IBAction func showGameInstructionsXXX(_ sender: UIButton) {
        infoView.displayMessage("""
                                How to Play:
                                1. Drag X or O piece onto thegrid
                                2. Take turns placing pieces
                                3. Get 3 consectuive pieces in a row or column or diagonal and you win!
                                """, isLongMessage: true)
        
        infoView.center.y = -infoView.bounds.height // / 2
        infoView.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.infoView.center.y = self.view.center.y
        }
    }
    
    // Show instructions and temporarily disable interactions
    @IBAction func showGameInstructions(_ sender: UIButton) {
        // Show game rules in the info view
        infoView.displayMessage("""
                                    How to Play:
                                    1. Drag X or O piece onto thegrid
                                    2. Take turns placing pieces
                                    3. Get 3 consectuive pieces in a row or column or diagonal and you win!
                                    """, isLongMessage: true)
        
        infoView.center.y = -infoView.bounds.height
        infoView.isHidden = false
        
        // Disable interactions while instructions are displayed.
        squares.forEach { $0.isUserInteractionEnabled = false }
        xLabel.isUserInteractionEnabled = false
        oLabel.isUserInteractionEnabled = false
        infoView.infoViewDismissButton.isUserInteractionEnabled = true
        
        // Animate the info view sliding into the center.
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.infoView.center.y = self.view.center.y
        }
    }
    
    // Place a piece and makr the square in grid, then check if game is to end and handle all cases
    private func placePiece(_ piece: UIView, in square: UIView, at index: Int) {
        UIView.animate(withDuration: 0.2) {
            piece.center = square.center
        } completion: { _ in
            // Update game state
            self.grid.markTheSquare(at: index, for: self.currentPlayer)
            piece.isUserInteractionEnabled = false
            
            // Check game end conditions
            if let winner = self.grid.checkWinner() { // winner
                self.handleWin(who: winner) 
            } else if self.grid.isATie() { // tie
                self.handleATie()
            } else { // game not over so switch turns
                self.switchPlayerTurns()
            }
        }
    }

    // Switch from current player to the other after their turn
    private func switchPlayerTurns() {
        
        // Create and position new piece for next turn
        if currentPlayer == .x {
            xLabel = createNewPiece(text: "X", at: startXCenter)
        } else {
            oLabel = createNewPiece(text: "O", at: startOCenter)
        }
        
        currentPlayer = currentPlayer == .x ? .o : .x
        
        // Set interaction states
        xLabel.isUserInteractionEnabled = currentPlayer == .x
        oLabel.isUserInteractionEnabled = currentPlayer == .o
        
        // Set alpha for both. New current is 1 and the other is 0.5
        xLabel.alpha = currentPlayer == .x ? 1.0 : 0.5
        oLabel.alpha = currentPlayer == .o ? 1.0 : 0.5
        
        animateCurrentPlayerPiece() // animate current player piece
    }

    // Create a new X or O piece with the given text and position.
    private func createNewPiece(text: String, at center: CGPoint) -> UILabel {
        let newPiece = UILabel()
        newPiece.text = text
        newPiece.textAlignment = .center
        newPiece.font = .systemFont(ofSize: pieceFontSize, weight: .bold)
        newPiece.frame.size = CGSize(width: pieceWidth, height: pieceWidth) // Match original label size
        newPiece.center = center
        
        // Add pan gesture recognizer to allow dragging.
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        newPiece.addGestureRecognizer(panGesture)
        
        view.addSubview(newPiece) // add as subview to view
        return newPiece
    }
    
}

