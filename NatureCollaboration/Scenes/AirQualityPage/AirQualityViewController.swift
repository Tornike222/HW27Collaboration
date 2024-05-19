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
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "BackgroundImage")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleForAirQuality: UILabel = {
        let label = UILabel()
        label.text = "Air Quality page"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionForAirQualityTitle: UILabel = {
        let label = UILabel()
        label.text = "Enter name of Country, State and City to get information about air quality"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
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
        button.setTitle("Search", for: .normal)
        return button
    }()
    
    private let stackViewForQualityInfoLabels: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = #colorLiteral(red: 0.1702060997, green: 0.2210938334, blue: 0.3300693631, alpha: 1)
        return stack
    }()
    
    private let viewForStack : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.1702060997, green: 0.2210938334, blue: 0.3300693631, alpha: 1)
        view.isHidden = true
        return view
    }()
    
    private let customLoader = CustomLoader(frame: CGRect(x: 0, y: 500, width: 100, height: 100))
    
    private var countryTextField: CustomTextField!
    private var stateTextField: CustomTextField!
    private var cityTextField: CustomTextField!
    
    //MARK: - Lifecycle
    
    init(viewModel: AirQualityViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        viewModel.delegate = self
        setupUI()
        addActionToButton()
        customLoader.addLoaderIndicator(view: view)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        addBackgroundImage()
        addTitleForAirQuality()
        addDescriptionForAirQualityTitle()
        addStackViewForQualityTitles()
        addButtonForAirQuality()
        addViewForStack()
        addStackViewForQualityInfoLabels()
        updateTextFields()
    }
    
    private func addBackgroundImage() {
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addTitleForAirQuality() {
        view.addSubview(titleForAirQuality)
        NSLayoutConstraint.activate([
            titleForAirQuality.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleForAirQuality.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleForAirQuality.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func addDescriptionForAirQualityTitle() {
        view.addSubview(descriptionForAirQualityTitle)
        NSLayoutConstraint.activate([
            descriptionForAirQualityTitle.topAnchor.constraint(equalTo: titleForAirQuality.bottomAnchor, constant: 10),
            descriptionForAirQualityTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionForAirQualityTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func addStackViewForQualityTitles() {
        view.addSubview(stackViewForQualityTitles)
        NSLayoutConstraint.activate([
            stackViewForQualityTitles.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewForQualityTitles.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackViewForQualityTitles.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }
    
    private func addButtonForAirQuality() {
        view.addSubview(buttonForAirQuality)
        NSLayoutConstraint.activate([
            buttonForAirQuality.topAnchor.constraint(equalTo: stackViewForQualityTitles.bottomAnchor, constant: 50),
            buttonForAirQuality.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonForAirQuality.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonForAirQuality.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonForAirQuality.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func addStackViewForQualityInfoLabels() {
        view.addSubview(stackViewForQualityInfoLabels)
        NSLayoutConstraint.activate([
            stackViewForQualityInfoLabels.leadingAnchor.constraint(equalTo: viewForStack.leadingAnchor, constant: 20),
            stackViewForQualityInfoLabels.trailingAnchor.constraint(equalTo: viewForStack.trailingAnchor, constant: -20),
            stackViewForQualityInfoLabels.bottomAnchor.constraint(equalTo: viewForStack.bottomAnchor, constant: -10)
        ])
    }
    
    private func addViewForStack() {
        view.addSubview(viewForStack)
        NSLayoutConstraint.activate([
            viewForStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewForStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewForStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            viewForStack.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func updateTextFields() {
        countryTextField = addDetailsToStackViewForQualityTitles(title: "Country :", placeholder: "e.g. Georgia")
        stateTextField = addDetailsToStackViewForQualityTitles(title: "State :", placeholder: "e.g. Imereti")
        cityTextField = addDetailsToStackViewForQualityTitles(title: "City :", placeholder: "e.g. Kutaisi")
    }
    
    // MARK: Methods
    private func addActionToButton() {
        buttonForAirQuality.addAction(UIAction(handler: { _ in
            self.deselectAllTextField()
            self.viewModel.checkAndFetchAirQuality(city: self.cityTextField.text, state: self.stateTextField.text, country: self.countryTextField.text)
         }), for: .touchUpInside)
    }
    
    private func updateStackViewForQualityInfoLabels() {
        stackViewForQualityInfoLabels.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for info in viewModel.airQualityInfo {
            let titleLabel = UILabel()
            titleLabel.font = UIFont(name: "FiraGO-Medium", size: 18)
            titleLabel.text = info.title
            titleLabel.textColor = .white
            
            let valueLabel = UILabel()
            valueLabel.font = UIFont(name: "FiraGO-Medium", size: 18)
            valueLabel.text = info.value
            valueLabel.textColor = .white
            
            let detailStack = UIStackView()
            detailStack.axis = .horizontal
            detailStack.distribution = .equalCentering
            detailStack.spacing = 20
            
            detailStack.addArrangedSubview(titleLabel)
            detailStack.addArrangedSubview(valueLabel)
            stackViewForQualityInfoLabels.addArrangedSubview(detailStack)
        }
    }
    
    private func addDetailsToStackViewForQualityTitles(title: String, placeholder: String) -> CustomTextField {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "FiraGO-Medium", size: 18)
        titleLabel.textColor = .white
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
    
    private func deselectAllTextField() {
        let textFields = [countryTextField, stateTextField, cityTextField]
        for textField in textFields {
            textField?.endEditing(true)
        }
    }
    
    private func highlightErrorFields() {
        let textFields = [countryTextField, stateTextField, cityTextField]
        for textField in textFields {
            if textField?.text?.isEmpty == true {
                textField?.layer.borderColor = UIColor.red.cgColor
            } else {
                textField?.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
}

extension AirQualityViewController: AirQualityViewModelDelegate {
    func updateAirQualityInfo() {
        updateStackViewForQualityInfoLabels()
    }
    
    func showAllert(message: String) {
        showError(message: message)
    }
    
    func showViewForStack() {
        viewForStack.isHidden = false
    }
    
    func textFieldsHighlighted() {
            highlightErrorFields()
        }
    
    func startAnimation() {
        self.customLoader.startAnimation()
    }
    
    func stopAnimation() {
        self.customLoader.stopAnimation()
    }
 }

#Preview {
    AirQualityViewController(viewModel: AirQualityViewModel())
}

