//
//  PopulationViewController.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

final class PopulationViewController: UIViewController {
    //MARK: - Properties
    var viewModel: PopulationViewModel!
    
    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Population Page"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Determine total population for a country today and tomorrow"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let countryNameLabel: UILabel = {
        let countryNameLabel = UILabel()
        countryNameLabel.text = "Country:"
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.font = UIFont(name: "FiraGO-Medium", size: 18)
        countryNameLabel.textColor = .white
        return countryNameLabel
    }()
    
    private let countryNameTextField: CustomTextField = {
        let textFiled = CustomTextField()
        textFiled.placeholder = "e.g. Georgia"
        return textFiled
    }()
    
    private let populationButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Search", for: .normal)
        return button
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "FiraGO-Medium", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "FiraGO-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueTodayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "FiraGO-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tomorrowLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueTomorrowLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewForValuesBackground: UIView = {
        let viewForValuesBackground = UIView()
        viewForValuesBackground.translatesAutoresizingMaskIntoConstraints = false
        viewForValuesBackground.backgroundColor = UIColor(red: 0.1702060997, green: 0.2210938334, blue: 0.3300693631, alpha: 1)
        viewForValuesBackground.layer.cornerRadius = 15
        viewForValuesBackground.isHidden = true
        return viewForValuesBackground
    }()
    
    //MARK: - Initialization VM
    init(viewModel: PopulationViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupUI()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        addBackgroundImage()
        setUpTitleLabel()
        setUpDescriptionLabel()
        addCountryNameLabel()
        addTextField()
        addButton()
        addViewForValuesBackground()
        addCountryLabel()
        addTodayLabel()
        addValueTodayLabel()
        addTomorrowLabel()
        addValueTomorrowLabel()
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
    
    private func setUpTitleLabel() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpDescriptionLabel() {
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func addCountryNameLabel() {
        view.addSubview(countryNameLabel)
        NSLayoutConstraint.activate([
            countryNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countryNameLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 80),
            countryNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func addTextField() {
        view.addSubview(countryNameTextField)
        NSLayoutConstraint.activate([
            countryNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            countryNameTextField.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 5),
            countryNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
        ])
    }
    
    private func addButton() {
        view.addSubview(populationButton)
        NSLayoutConstraint.activate([
            populationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            populationButton.topAnchor.constraint(equalTo: countryNameTextField.bottomAnchor, constant: 40),
            populationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        addActionToSearchButton()
    }
    
    private func addActionToSearchButton() {
        populationButton.addAction(UIAction.init(handler: { [weak self] _ in
            self?.viewModel.fetchPopulationData(country: self?.countryNameTextField.text)
            self?.countryLabel.text = self?.countryNameTextField.text
        }), for: .touchUpInside)
    }
    
    private func addViewForValuesBackground() {
        view.addSubview(viewForValuesBackground)
        NSLayoutConstraint.activate([
            viewForValuesBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewForValuesBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewForValuesBackground.topAnchor.constraint(equalTo: populationButton.bottomAnchor, constant: 50),
            viewForValuesBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func addCountryLabel() {
        view.addSubview(countryLabel)
        NSLayoutConstraint.activate([
            countryLabel.centerXAnchor.constraint(equalTo: viewForValuesBackground.centerXAnchor),
            countryLabel.topAnchor.constraint(equalTo: viewForValuesBackground.topAnchor, constant: 40)
        ])
    }
    
    private func addTodayLabel() {
        view.addSubview(todayLabel)
        NSLayoutConstraint.activate([
            todayLabel.leadingAnchor.constraint(equalTo: viewForValuesBackground.leadingAnchor, constant: 20),
            todayLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 50)
        ])
    }
    
    private func addValueTodayLabel() {
        view.addSubview(valueTodayLabel)
        NSLayoutConstraint.activate([
            valueTodayLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 50),
            valueTodayLabel.trailingAnchor.constraint(equalTo: viewForValuesBackground.trailingAnchor, constant: -20)
        ])
    }
    
    private func addTomorrowLabel() {
        view.addSubview(tomorrowLabel)
        NSLayoutConstraint.activate([
            tomorrowLabel.leadingAnchor.constraint(equalTo: viewForValuesBackground.leadingAnchor, constant: 20),
            tomorrowLabel.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 40)
        ])
    }
    
    private func addValueTomorrowLabel() {
        view.addSubview(valueTomorrowLabel)
        NSLayoutConstraint.activate([
            valueTomorrowLabel.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 40),
            valueTomorrowLabel.trailingAnchor.constraint(equalTo: viewForValuesBackground.trailingAnchor, constant: -20),
        ])
    }

}
extension PopulationViewController: PopulationViewModelDelegate {
    func updatePopulation(with totalPopulation: [TotalPopulation]) {
        self.todayLabel.text = totalPopulation[0].date
        self.valueTodayLabel.text = String(totalPopulation[0].population ?? 0)
    
        self.tomorrowLabel.text = totalPopulation[1].date
        self.valueTomorrowLabel.text = String(totalPopulation[1].population ?? 0)
        viewForValuesBackground.isHidden = false
        }
    }

