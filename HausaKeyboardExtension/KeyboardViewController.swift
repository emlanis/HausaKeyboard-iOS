//
//  KeyboardViewController.swift
//  HausaKeyboardExtension
//
//  Created by emlanis on 20/10/2025.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var isShifted = false
    var keyboardView: UIView!
    
    // Hausa special characters
    let hausaChars = ["ɓ", "ɗ", "ƙ", "ƴ", "ʼy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
    }
    
    func setupKeyboard() {
        // Remove any existing views
        view.subviews.forEach { $0.removeFromSuperview() }
        
        // Create main container
        keyboardView = UIView()
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        keyboardView.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        view.addSubview(keyboardView)
        
        // Constraints for keyboard view
        NSLayoutConstraint.activate([
            keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardView.topAnchor.constraint(equalTo: view.topAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            keyboardView.heightAnchor.constraint(equalToConstant: 270)
        ])
        
        // Create keyboard rows
        createKeyboardLayout()
    }
    
    func createKeyboardLayout() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        keyboardView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: keyboardView.leadingAnchor, constant: 3),
            stackView.trailingAnchor.constraint(equalTo: keyboardView.trailingAnchor, constant: -3),
            stackView.topAnchor.constraint(equalTo: keyboardView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: keyboardView.bottomAnchor, constant: -8)
        ])
        
        // Row 1: Numbers and Hausa characters
        let row1 = createRow(keys: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"])
        stackView.addArrangedSubview(row1)
        
        // Row 2: Top letter row with Hausa chars
        let row2 = createRow(keys: ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"])
        stackView.addArrangedSubview(row2)
        
        // Row 3: Middle letter row
        let row3 = createRow(keys: ["a", "s", "d", "f", "g", "h", "j", "k", "l"])
        stackView.addArrangedSubview(row3)
        
        // Row 4: Bottom letter row with shift
        let row4 = createBottomRow()
        stackView.addArrangedSubview(row4)
        
        // Row 5: Space, Hausa characters, and special keys
        let row5 = createLastRow()
        stackView.addArrangedSubview(row5)
    }
    
    func createRow(keys: [String]) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fillEqually
        row.spacing = 6
        
        for key in keys {
            let button = createKeyButton(key: key)
            row.addArrangedSubview(button)
        }
        
        return row
    }
    
    func createBottomRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 6
        row.distribution = .fill
        
        // Shift button
        let shiftButton = createKeyButton(key: "⇧")
        shiftButton.removeTarget(nil, action: nil, for: .allEvents)
        shiftButton.addTarget(self, action: #selector(shiftPressed), for: .touchUpInside)
        shiftButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        row.addArrangedSubview(shiftButton)
        
        // Letter keys
        let letters = ["z", "x", "c", "v", "b", "n", "m"]
        let letterStack = createRow(keys: letters)
        row.addArrangedSubview(letterStack)
        
        // Backspace button
        let backButton = createKeyButton(key: "⌫")
        backButton.removeTarget(nil, action: nil, for: .allEvents)
        backButton.addTarget(self, action: #selector(backspacePressed), for: .touchUpInside)
        backButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        row.addArrangedSubview(backButton)
        
        return row
    }
    
    func createLastRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 6
        row.distribution = .fill
        
        // Globe/switch keyboard button
        let globeButton = createKeyButton(key: "🌐")
        globeButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        globeButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        row.addArrangedSubview(globeButton)
        
        // Hausa special characters
        for char in hausaChars {
            let button = createKeyButton(key: char)
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
            row.addArrangedSubview(button)
        }
        
        // Space bar
        let spaceButton = createKeyButton(key: "space")
        spaceButton.addTarget(self, action: #selector(spacePressed), for: .touchUpInside)
        row.addArrangedSubview(spaceButton)
        
        // Return key
        let returnButton = createKeyButton(key: "return")
        returnButton.addTarget(self, action: #selector(returnPressed), for: .touchUpInside)
        returnButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        row.addArrangedSubview(returnButton)
        
        return row
    }
    
    func createKeyButton(key: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let displayText = isShifted ? key.uppercased() : key.lowercased()
        button.setTitle(displayText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 0
        
        button.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc func keyPressed(_ sender: UIButton) {
        guard let key = sender.titleLabel?.text else { return }
        
        let textToInsert: String
        if key == "space" {
            textToInsert = " "
        } else if key == "return" {
            textToInsert = "\n"
        } else {
            textToInsert = key
        }
        
        textDocumentProxy.insertText(textToInsert)
        
        // Auto-unshift after typing a letter (except for Hausa special chars)
        if isShifted && !hausaChars.contains(key.lowercased()) && key != "⇧" {
            isShifted = false
            setupKeyboard()
        }
    }
    
    @objc func shiftPressed() {
        isShifted.toggle()
        setupKeyboard()
    }
    
    @objc func backspacePressed() {
        textDocumentProxy.deleteBackward()
    }
    
    @objc func spacePressed() {
        textDocumentProxy.insertText(" ")
    }
    
    @objc func returnPressed() {
        textDocumentProxy.insertText("\n")
    }
}
