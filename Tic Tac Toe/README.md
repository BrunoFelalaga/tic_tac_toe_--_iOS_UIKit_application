
# Tic Tac Toe - Gesture Driven iOS Game

A gesture-based Tic Tac Toe game for two players on a single device using `UIGestureRecognizer`, `UIView animations`, and `CALayer`.

## Features

- **Interactive Grid:** Custom-drawn grid using `UIBezierPath`.
- **Drag & Drop Gameplay:** Players drag `X` and `O` pieces using `UIPanGestureRecognizer`.
- **Animated Turns:** Highlights current player with animations.
- **Win Detection:** Checks for a win/tie and displays results with animations.
- **Info View:** Animated instructions and game results display.

## Installation

1. Clone the repo:  
   ```sh
   git clone https://github.com/uchicago-mobi/mpcs51030-2025-winter-assignment-4-BrunoFelalaga.git
   ```
2. Open in Xcode and run on an iPhone 15 simulator.

## Implementation Details

- `GridView.swift`: Draws the game board.
- `ViewController.swift`: Manages game logic and user interactions.
- `Grid.swift`: Tracks game state and determines win/tie conditions.
- `InfoView.swift`: Displays game instructions and results.
- Uses `UIViewPropertyAnimator` for animations and `CABasicAnimation` for the winning line.

## Credits

Developed by Bruno Felalaga for **MPCS 51030 iOS Application Development**. 
Free Icon source: https://www.iconfinder.com/icons/190322/game_tac_tic_toe_icon
Animating Win with Line: https://www.hackingwithswift.com/example-code/calayer/how-to-make-a-shape-draw-itself-using-strokeend
