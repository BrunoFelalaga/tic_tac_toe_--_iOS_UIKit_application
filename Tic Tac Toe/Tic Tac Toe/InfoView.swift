//
//  InfoView.swift
//  Tic Tac Toe
//
//  Created by Bruno Felalaga on 2/2/25.
//

import UIKit


class InfoView: UIView {
    
    @IBOutlet private var infoViewLabel: UILabel!
    @IBOutlet private var infoViewDismissButton: UIButton!
    
    private var dismissHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpInfoView()
    }
    
    private func setUpInfoView() {
        layer.cornerRadius = 12
        layer.borderColor = UIColor.purple.cgColor
        layer.borderWidth = 2
        
        // Add shadow properties
        layer.shadowColor = UIColor.purple.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        
        
        infoViewDismissButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(infoViewDismissButton)
        
        infoViewDismissButton.layer.cornerRadius = 5
        infoViewDismissButton.layer.backgroundColor = UIColor.blue.cgColor
        
        NSLayoutConstraint.activate(
            [infoViewDismissButton.centerXAnchor.constraint(equalTo: centerXAnchor),
             infoViewDismissButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0),
             infoViewDismissButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
             infoViewDismissButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
            ]
        )
        
        
        infoViewLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(infoViewLabel)
        
        infoViewLabel.layer.cornerRadius = 5
        infoViewLabel.layer.backgroundColor = UIColor.purple.cgColor
        infoViewLabel.text = "Get 3 in a row to win!"
        
        NSLayoutConstraint.activate(
            [infoViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
             infoViewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60.0),
             infoViewLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
             infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
            ]
        )
//
        
//        -
//        infoViewDismissButton.frame.origin.x = self.frame.origin.x + 1
//        infoViewDismissButton.frame.origin.y = self.frame.origin.y + 1
//        infoViewDismissButton.frame.size.width = self.frame.width * 0.8
//        infoViewDismissButton.frame.size.height = self.frame.height * 0.5
        
        
        
        
        
        
        infoViewDismissButton.addTarget(self, action: #selector(infoViewDismissButtonTapped), for: .touchUpInside)
//        addSubview(infoViewDismissButton)
    }
    
    @objc private func infoViewDismissButtonTapped() {
        let screenHeight = UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.frame.origin.y = screenHeight
        } completion: { _ in
            self.dismissHandler?()
            self.frame.origin.y = -self.frame.height}
    }
    
    
}
