//
//  CustomButton.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

final class CustomButton: UIButton{
    //MARK: - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        touch()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
        touch()
    }
    //MARK: - Functions
    private func setupButton(){
        var config = Configuration.plain()
        let font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 15)
        let attributedTitle = NSAttributedString(string: "", attributes: [.font: font])
        config.attributedTitle = AttributedString(attributedTitle)
        config.contentInsets =  NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20)
        configuration = config
        sizeToFit()
        backgroundColor = UIColor.systemBlue
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 25
        setTitleColor(.white, for: .normal)
    }
    
    private func touch(){
        addAction(UIAction(handler: { _ in
            self.buttonTouchedDown()
        }), for: .touchDown)
        
        addAction(UIAction(handler: { _ in
            self.buttonTouchedUp()
        }), for: .touchUpInside)
    }
    
    private func buttonTouchedDown(){
        tintColor = .white
        layer.opacity = 0.5
    }
    
    private func buttonTouchedUp(){
        layer.opacity = 1
    }
    
}
