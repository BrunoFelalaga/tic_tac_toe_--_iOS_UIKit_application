//
//  InfoView.swift
//  Tic Tac Toe
//
//  Created by Bruno Felalaga on 2/2/25.
//

import UIKit


class InfoView: UIView {
    
    @IBOutlet private var infoViewLabel: UILabel!
    @IBOutlet var infoViewDismissButton: UIButton!
    private var dismissHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpInfoView()
    }
    
    // Configure the infoview with styling and layout constraints
    private func setUpInfoView() {

        // // Set background color and border styling
        // backgroundColor = UIColor.red.withAlphaComponent(1.0)
        // layer.cornerRadius = 12
        // layer.borderColor = UIColor.purple.cgColor
        // layer.borderWidth = 2
        
        // // Add shadow properties
        // layer.shadowColor = UIColor.purple.cgColor
        // layer.shadowRadius = 4
        // layer.shadowOpacity = 0.2
        configureViewAppearance()

        // infoViewDismissButton.translatesAutoresizingMaskIntoConstraints = false
        // addSubview(infoViewDismissButton)
        
        // infoViewDismissButton.layer.cornerRadius = 5
        // infoViewDismissButton.layer.backgroundColor = UIColor.blue.cgColor
        
        // // Set constraints for the dismiss button.
        // NSLayoutConstraint.activate(
        //     [infoViewDismissButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        //      infoViewDismissButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0),
        //      infoViewDismissButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        //      infoViewDismissButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        //     ]
        // )
        setupButton()

        // // Configure and add the label
        // infoViewLabel.translatesAutoresizingMaskIntoConstraints = false
        // addSubview(infoViewLabel)
        
        // infoViewLabel.layer.cornerRadius = 5
        // infoViewLabel.layer.backgroundColor = UIColor.purple.cgColor
        // infoViewLabel.text = "Get 3 in a row to win!"
        
        // // Set constraints for the label.
        // NSLayoutConstraint.activate(
        //     [infoViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        //      infoViewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60.0),
        //      infoViewLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        //      infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        //     ]
        // )

        setupLabel()
        
        // Add dismiss button action
        // infoViewDismissButton.addTarget(self, action: #selector(infoViewDismissButtonTapped), for: .touchUpInside)

    }

    private func configureViewAppearance() {
        backgroundColor = UIColor.red.withAlphaComponent(1.0)
        layer.cornerRadius = 12
        layer.borderColor = UIColor.purple.cgColor
        layer.borderWidth = 2
        layer.shadowColor = UIColor.purple.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
    }

        
    private func setupButton() {
        infoViewDismissButton.translatesAutoresizingMaskIntoConstraints = false
        infoViewDismissButton.layer.cornerRadius = 5
        
        infoViewDismissButton.layer.backgroundColor = UIColor.blue.cgColor
        addSubview(infoViewDismissButton)
        
        NSLayoutConstraint.activate([
            infoViewDismissButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoViewDismissButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0),
            infoViewDismissButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            infoViewDismissButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
        
        infoViewDismissButton.addTarget(self, 
                                      action: #selector(infoViewDismissButtonTapped), 
                                      for: .touchUpInside)
    }
    
     private func setupLabel() {
        infoViewLabel.translatesAutoresizingMaskIntoConstraints = false
        infoViewLabel.layer.cornerRadius = 5
        infoViewLabel.layer.backgroundColor = UIColor.purple.cgColor
        infoViewLabel.text = "Get 3 in a row to win!"
        addSubview(infoViewLabel)
        
        NSLayoutConstraint.activate([
            infoViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoViewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60.0),
            infoViewLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    
    
    @objc private func infoViewDismissButtonTappedxxx() {
        let screenHeight = UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.frame.origin.y = screenHeight
        } completion: { _ in
            //            self.dismissHandler?()
            self.frame.origin.y = -self.frame.height
            self.isHidden = true

        }
    }
    
    
    // Dismiss infoview and re-enable game interactions
    @objc private func infoViewDismissButtonTapped() {
        let screenHeight = UIScreen.main.bounds.height
        
        // Re-enable interactions for game pieces and squares.
        if let viewController = self.superview as? UIView { // Get reference to view controller's view
            // Re-enable interactions for game pieces and squares
            viewController.subviews.forEach { view in
                if view.tag >= 0 && view.tag <= 8 { // Enable square interactions
                    view.isUserInteractionEnabled = true
                } else if let label = view as? UILabel,
                          label.text == "X" || label.text == "O" {
                    label.isUserInteractionEnabled = true
                }
            }
        }
        
        // Animate the info view sliding off-screen, then hide it.
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.frame.origin.y = screenHeight
        } completion: { _ in
            self.frame.origin.y = -self.frame.height
            self.isHidden = true
        }
    }
    
    
    // Displays a message in the info view and adjusts its size based on message length.
    public func displayMessage(_ message: String, isLongMessage: Bool = false) {
        infoViewLabel.text = message
        infoViewLabel.numberOfLines = 0 // Allow multiple lines
  
        //  Adjust the size of the info view based on message length.
        if isLongMessage {
            frame = CGRect(x: frame.origin.x - 25, y: frame.origin.y, width: frame.width + 50, height: 300)
            
            // Update label constraints for a larger message
            NSLayoutConstraint.activate([
                infoViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                infoViewLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20.0),
                infoViewLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
            ])
        } else {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 200)
            
            // Update label constraints for a shorter message
            NSLayoutConstraint.activate([
                infoViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                infoViewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60.0),
                infoViewLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
            ])
        }
    }


    
}
