class InfoView: UIView {
    @IBOutlet private var infoViewLabel: UILabel!
    @IBOutlet private var infoViewDismissButton: UIButton!
    private var dismissHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        configureViewAppearance()
        setupButton()
        setupLabel()
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
    
    @objc private func infoViewDismissButtonTapped() {
        let screenHeight = UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.frame.origin.y = screenHeight
        } completion: { _ in
            self.dismissHandler?()
            self.frame.origin.y = -self.frame.height
        }
    }
    
    public func displayMessage(_ message: String) {
        infoViewLabel.text = message
    }
}