//
//  SolarResourceViewController.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

class SolarResourceViewController: UIViewController {
    //MARK: - Properties
    var viewModel: SolarResourceViewModel!
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackgroundImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let solarButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        addBackground()
        setupLabel()
        setupTextField()
        setupButton()
    }
    

    //MARK: - Initialization VM
    init(viewModel: SolarResourceViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBackground() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func setupLabel() {
        view.addSubview(addressLabel)
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addressLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        addressLabel.font = UIFont(name: "FiraGO-Medium", size: 18)
        addressLabel.textColor = .white
        addressLabel.text = "Enter your address:"
    }
    
    func setupTextField() {
        view.addSubview(addressTextField)
        NSLayoutConstraint.activate([
            addressTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addressTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addressTextField.placeholder = "e.g. konkretuli misamarti"
    }
    
    func setupButton() {
        view.addSubview(solarButton)
        NSLayoutConstraint.activate([
            solarButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            solarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            solarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            solarButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        solarButton.setTitle("Let's go", for: .normal)
    }
}

#Preview {
    SolarResourceViewController(viewModel: SolarResourceViewModel())
}
