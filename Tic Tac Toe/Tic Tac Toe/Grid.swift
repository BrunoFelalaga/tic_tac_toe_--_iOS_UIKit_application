//
//  Grid.swift
//  Tic Tac Toe
//
//  Created by Bruno Felalaga on 2/2/25.
//


class Grid {
    
    // Stores the game board state with 9 positions, initially set to empty.
    private var squares: [Player] = Array(repeating: .none, count: 9)
    
    // var with all winning combinations
    private var winningCombos = [
        [0,1,2], [3,4,5], [6,7,8],
        [0,3,6], [1,4,7], [2,5,8],
        [0,4,8], [2,4,6]
    ]
    
    // Check if square is empty by index
    func isSquareEmpty(at index: Int) -> Bool {
        print("ix: \(index), len sqs: \(squares.count)")
        return squares[index] == .none
    }
    
    // Marks a square on the board with the given player's move.
    func markTheSquare(at index: Int, for player: Player) {
        squares[index] = player
    }
    
    // Check for winner by comparing squares for each combo to see if they have same label
    func checkWinner() -> Player? {
        for combo in winningCombos {
            let pieceOne = squares[combo[0]]
            let pieceTwo = squares[combo[1]]
            let pieceThree = squares[combo[2]]
            
            // compare all squares in each combination
            if pieceOne != .none && pieceOne == pieceTwo && pieceOne == pieceThree {
                return pieceOne // return winning piece
            }
        }
        return nil // return nil if no win found
        
    }
    
    // Get the winning combination by comparing squares for each combo to see if they have same label
    func getWinningCombination() -> [Int]? {
        for combo in winningCombos{
            let pieceOne = squares[combo[0]]
            let pieceTwo = squares[combo[1]]
            let pieceThree = squares[combo[2]]

            // compare all squares in each combination
            if pieceOne != .none && pieceOne == pieceTwo && pieceOne == pieceThree {
                return combo // return winning combination
            }
        }
        return nil // return nil if no win found
    }
    
    
    
    
    // Check if the game is a tie by ensuring all squares are filled and no winner exists.
    func isATie() -> Bool {
        return !squares.contains(.none) && checkWinner() == nil
    }
    
    // Resets the game board by clearing all squares.
    func reset() {
        squares = Array(repeating: .none, count: 9)
    }
    
    
    
    
    
    
    
}
