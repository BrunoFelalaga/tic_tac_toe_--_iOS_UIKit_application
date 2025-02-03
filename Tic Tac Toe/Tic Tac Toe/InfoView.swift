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
//    @IBOutlet private var infoViewDismissButton: UIButton!
    
//    init{}
    private var dismissHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpInfoView()
    }
    
    private func setUpInfoView() {
        
        backgroundColor = UIColor.red.withAlphaComponent(1.0)
//                layer.cornerRadius = 12
//                layer.borderColor = UIColor.systemBlue.cgColor
//                layer.borderWidth = 2
        
        layer.cornerRadius = 12
        layer.borderColor = UIColor.purple.cgColor
        layer.borderWidth = 2
        
        // Add shadow properties
        layer.shadowColor = UIColor.purple.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        
        // Get reference to view controller's view
        if let viewController = self.superview as? UIView {
            // Re-enable interactions for game pieces and squares
            viewController.subviews.forEach { view in
                if view.tag >= 0 && view.tag <= 8 { // Square views
                    view.isUserInteractionEnabled = false
                    print("jdjdjdjd")
                } else if let label = view as? UILabel,
                          label.text == "X" || label.text == "O" {
                    print("lslsls")
//                    label.isUserInteractionEnabled = true
                } else { print("lll\(view.isUserInteractionEnabled) tt : \(String(describing: type(of :view)))")}
            }
        }
//        
        
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
        
        infoViewDismissButton.addTarget(self, action: #selector(infoViewDismissButtonTapped), for: .touchUpInside)
//        addSubview(infoViewDismissButton)
    }
    
    @objc private func infoViewDismissButtonTappedxxx() {
        let screenHeight = UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.frame.origin.y = screenHeight
        } completion: { _ in
            //            self.dismissHandler?()
            self.frame.origin.y = -self.frame.height
            self.isHidden = true
//            self.window?.isUserInteractionEnabled = true //---
//            self.superview?.isUserInteractionEnabled = true //
            
//            if let viewController = self.superview as? ViewController {
//                viewController.view.isUserInteractionEnabled = viewController.previousInteractionState
//            }
        }
    }
    
    
    
    @objc private func infoViewDismissButtonTapped() {
        let screenHeight = UIScreen.main.bounds.height
        
        // Get reference to view controller's view
        if let viewController = self.superview as? UIView {
            // Re-enable interactions for game pieces and squares
            viewController.subviews.forEach { view in
                if view.tag >= 0 && view.tag <= 8 { // Square views
                    view.isUserInteractionEnabled = true
                } else if let label = view as? UILabel,
                          label.text == "X" || label.text == "O" {
                    label.isUserInteractionEnabled = true
                }
            }
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.frame.origin.y = screenHeight
        } completion: { _ in
            self.frame.origin.y = -self.frame.height
            self.isHidden = true
        }
    }
    
    
//    @objc private func infoViewDismissButtonTapped() {
//        let screenHeight = UIScreen.main.bounds.height
//        
//        let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.8) {
//            self.center.y = screenHeight + self.frame.height/2
//            self.transform = CGAffineTransform(rotationAngle: .pi/8)
//        }
//        
//        print("hehehe")
//        animator.addCompletion { _ in
//            self.dismissHandler?()
//            self.transform = .identity
//            self.frame.origin.y = -self.frame.height
//        }
//        
//        animator.startAnimation()
//    }
        
//    public func displayMessage(_ message: String, isLongMessage: Bool = false) {
//        infoViewLabel.text = message
//        if isLongMessage {
//            NSLayoutConstraint.activate([infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 5.5)])
//        } else {
//            NSLayoutConstraint.activate(
//                [infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)]
//            )
//        }
////        infoViewLabel.text = message
//    }
    
    public func displayMessageo(_ message: String, isLongMessage: Bool = false) {
        infoViewLabel.text = message
        
        if isLongMessage {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y,
                           width: frame.width, height: 300)

            infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        } else {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y,
                           width: frame.width, height: 200)
            infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        }
        infoViewLabel.numberOfLines = 0
    }
    
    public func displayMessage(_ message: String, isLongMessage: Bool = false) {
        infoViewLabel.text = message
        infoViewLabel.numberOfLines = 0
        // Get reference to view controller's view
        if let viewController = self.superview as? UIView {
            // Re-enable interactions for game pieces and squares
            viewController.subviews.forEach { view in
                if view.tag >= 0 && view.tag <= 8 { // Square views
                    view.isUserInteractionEnabled = false
                    print("jdjdjdjd")
                } else if let label = view as? UILabel,
                          label.text == "X" || label.text == "O" {
                    print("lslsls")
                    label.isUserInteractionEnabled = true
                }
            }
        }
        
        
        if isLongMessage {
            //frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width+50, height: 300)
            frame = CGRect(x: frame.origin.x - 25, y: frame.origin.y, width: frame.width + 50, height: 300)
            NSLayoutConstraint.activate([
                infoViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                infoViewLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20.0),
                infoViewLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
            ])
        } else {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 200)
            NSLayoutConstraint.activate([
                infoViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                infoViewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60.0),
                infoViewLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                infoViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
            ])
        }
    }


    
}
