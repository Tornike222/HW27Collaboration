//
//  AirQualityViewController.swift
//  NatureCollaboration
//
//  Created by sandrogelashvili on 17.05.24.
//

import UIKit

final class AirQualityViewController: UIViewController {
    //MARK: - Properties
    var viewModel: AirQualityViewModel
    
    // MARK: - UI Components
    private let stackViewForQualityTitles: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let buttonForAirQuality: CustomButton = {
        let button = CustomButton()
        button.setTitle("Press", for: .normal)
        return button
    }()
    
    private let stackViewForQualityInfoLabels: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    private var countryTextField: CustomTextField!
    private var stateTextField: CustomTextField!
    private var cityTextField: CustomTextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        viewModel.delegate = self
        setUpUI()
        addActionToButton()
    }
    
    //MARK: - Initialization VM
    init(viewModel: AirQualityViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setUpUI() {
        view.addSubview(stackViewForQualityTitles)
        view.addSubview(buttonForAirQuality)
        view.addSubview(stackViewForQualityInfoLabels)
        NSLayoutConstraint.activate([
            stackViewForQualityTitles.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackViewForQualityTitles.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackViewForQualityTitles.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            buttonForAirQuality.topAnchor.constraint(equalTo: stackViewForQualityTitles.bottomAnchor, constant: 50),
            buttonForAirQuality.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonForAirQuality.widthAnchor.constraint(equalToConstant: 200),
            buttonForAirQuality.heightAnchor.constraint(equalToConstant: 50),
            stackViewForQualityInfoLabels.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackViewForQualityInfoLabels.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackViewForQualityInfoLabels.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        countryTextField = addDetailsToStackViewForQualityTitles(title: "Country :", placeholder: "e.g. Georgia")
        stateTextField = addDetailsToStackViewForQualityTitles(title: "State :", placeholder: "e.g. Imereti")
        cityTextField = addDetailsToStackViewForQualityTitles(title: "City :", placeholder: "e.g. Kutaisi")
        
    }
    
    // MARK: Methods
    func addActionToButton() {
        buttonForAirQuality.addAction(UIAction(handler: { _ in
            guard let country = self.countryTextField.text, !country.isEmpty,
                  let state = self.stateTextField.text, !state.isEmpty,
                  let city = self.cityTextField.text, !city.isEmpty else {
                self.showError(message: "Please fill in all fields")
                return
            }
            self.viewModel.fetchAirQualityData(city: city, state: state, country: country)
        }), for: .touchUpInside)
    }
    
    private func updateStackViewForQualityInfoLabels() {
        stackViewForQualityInfoLabels.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for info in viewModel.airQualityInfo {
            let titleLabel = UILabel()
            titleLabel.font = UIFont(name: "FiraGO-Medium", size: 14)
            titleLabel.text = info.title
            let valueLabel = UILabel()
            valueLabel.font = UIFont(name: "FiraGO-Medium", size: 14)
            valueLabel.text = info.value
            let detailStack = UIStackView()
            detailStack.axis = .horizontal
            detailStack.distribution = .equalCentering
            detailStack.spacing = 10
            detailStack.addArrangedSubview(titleLabel)
            detailStack.addArrangedSubview(valueLabel)
            
            stackViewForQualityInfoLabels.addArrangedSubview(detailStack)
        }
    }
    
    private func addDetailsToStackViewForQualityTitles(title: String, placeholder: String) -> CustomTextField {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "FiraGO-Medium", size: 14)
        titleLabel.text = title
        
        let textField = CustomTextField()
        textField.placeholder = placeholder
        
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 5
        
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(textField)
        
        stackViewForQualityTitles.addArrangedSubview(verticalStack)
        
        return textField
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension AirQualityViewController: AirQualityViewModelDelegate {
    func updateAirQualityInfo() {
        updateStackViewForQualityInfoLabels()
    }
}

#Preview {
    AirQualityViewController(viewModel: AirQualityViewModel())
}

