//
//  CustomTextField.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

class CustomTextField: UITextField {
    //MARK: - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        touch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func setupTextField(){
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "FiraGO-Regular", size: 15)
        backgroundColor = .clear
        textColor = .white
        attributedPlaceholder = NSAttributedString(string: "default", attributes: [
            .foregroundColor: #colorLiteral(red: 0.5529411435, green: 0.5529412031, blue: 0.5529411435, alpha: 1)
        ])
        borderStyle = .roundedRect
        layer.masksToBounds = true
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.5529411435, green: 0.5529412031, blue: 0.5529411435, alpha: 1)

    }

    func touch(){
        addAction(UIAction(handler: { _ in
            self.textFieldTouchedDown()
        }), for: .editingDidBegin)
        
        addAction(UIAction(handler: { _ in
            self.textFieldTouchedUp()
        }), for: .editingDidEnd)
    }
    
    func textFieldTouchedDown(){
        layer.borderColor = #colorLiteral(red: 0.006170265842, green: 0.4581519961, blue: 0.999124825, alpha: 1)
    }
    
    func textFieldTouchedUp(){
        layer.borderColor = #colorLiteral(red: 0.5529411435, green: 0.5529412031, blue: 0.5529411435, alpha: 1)
    }
    
}
