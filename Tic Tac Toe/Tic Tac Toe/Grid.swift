//
//  Grid.swift
//  Tic Tac Toe
//
//  Created by Bruno Felalaga on 2/2/25.
//


class Grid {
    
    private var squares: [Player] = Array(repeating: .none, count: 9)
    
    private var winningCombos = [
        [0,1,2], [3,4,5], [6,7,8],
        [0,3,6], [1,4,7], [2,5,8],
        [0,4,8], [2,4,6]
    ]
    
    func isSquareEmpty(at index: Int) -> Bool {
        print("ix: \(index), len sqs: \(squares.count)")
        return squares[index] == .none
    }
    
    func markTheSquare(at index: Int, for player: Player) {
        squares[index] = player
    }
    
    func checkWinner() -> Player? {
        for combo in winningCombos {
            let pieceOne = squares[combo[0]]
            let pieceTwo = squares[combo[1]]
            let pieceThree = squares[combo[2]]
            
            if pieceOne != .none && pieceOne == pieceTwo && pieceOne == pieceThree {
                return pieceOne
            }
        }
        return nil
        
    }
    
    func getWinningCombination() -> [Int]? {
        for combo in winningCombos{
            let pieceOne = squares[combo[0]]
            let pieceTwo = squares[combo[1]]
            let pieceThree = squares[combo[2]]
            
            if pieceOne != .none && pieceOne == pieceTwo && pieceOne == pieceThree {
                return combo
            }
        }
        return nil
    }
    
    
    
    
    func isATie() -> Bool {
        return !squares.contains(.none) && checkWinner() == nil
    }
    
    func reset() {
        squares = Array(repeating: .none, count: 9)
    }
    
    
    
    
    
    
    
}
