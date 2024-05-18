//
//  SolarResourceViewController.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

final class SolarResourceViewController: UIViewController {
    
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
    
    let solarDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var solarData: SolarData?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupUI()
        viewModel.delegate = self
        solarButtonTapped()
    }
    
    //MARK: - Initialization VM
    init(viewModel: SolarResourceViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI
    private func setupUI() {
        addSolarBackground()
        addSolarLabel()
        addSolarTextField()
        addSolarButton()
        addSolarDataLabel()
    }
    
    private func addSolarBackground() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func addSolarLabel() {
        view.addSubview(addressLabel)
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addressLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        addressLabel.font = UIFont(name: "FiraGO-Medium", size: 18)
        addressLabel.textColor = .white
        addressLabel.text = "Enter your address:"
    }
    
    private func addSolarTextField() {
        view.addSubview(addressTextField)
        NSLayoutConstraint.activate([
            addressTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addressTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        addressTextField.placeholder = "e.g. 1600 Pennsylvania Avenue NW, Washington, DC 20500"
        addressTextField.font = UIFont(name: "FiraGO-Medium", size: 12)
    }
    
    private func addSolarButton() {
        view.addSubview(solarButton)
        NSLayoutConstraint.activate([
            solarButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            solarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            solarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            solarButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        solarButton.setTitle("Let's go", for: .normal)
        solarButton.addAction(UIAction.init(handler: { [weak self] _ in
            self?.solarButtonTapped()
            self?.viewModel.formatSolarData(with: self?.addressTextField.text) { [weak self] solarDataText in
                DispatchQueue.main.async {
                    self?.solarDataLabel.text = solarDataText
                }
            }
        }), for: .touchUpInside)
    }
    
    private func addSolarDataLabel() {
        view.addSubview(solarDataLabel)
        NSLayoutConstraint.activate([
            solarDataLabel.topAnchor.constraint(equalTo: solarButton.bottomAnchor, constant: 50),
            solarDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            solarDataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        solarDataLabel.textColor = .white
        solarDataLabel.font = UIFont(name: "FiraGO-Medium", size: 16)
    }
    
    private func solarButtonTapped() {
        guard let address = addressTextField.text, !address.isEmpty else {
            presentAlert(title: "Error", message: "Please enter an address.")
            return
        }
        viewModel.formatSolarData(with: address) { [weak self] solarDataText in
            guard let self = self else { return }
            
            if let solarDataText = solarDataText, solarDataText != "Failed to fetch data" {
                self.solarDataLabel.text = solarDataText
            } else {
                self.presentAlert(title: "Error", message: "Please check your address and try again.")
            }
        }
    }
   
}
      // MARK: - extension
extension SolarResourceViewController: SolarResourceViewModelDelegate {
    func showError(_ error: String) {
        presentAlert(title: "Error", message: error)
    }
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


