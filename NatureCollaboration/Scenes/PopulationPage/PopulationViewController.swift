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
    
    private let countryNametextField: CustomTextField = {
        let textFiled = CustomTextField()
        textFiled.placeholder = "Country"
        return textFiled
    }()
    
    private let populationButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Search", for: .normal)
        return button
    }()
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "FiraGO-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueTodayLabel: UILabel = {
        let label = UILabel()
        label.text = "-----"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tomorrowLabel: UILabel = {
        let label = UILabel()
        label.text = "Tomorrow"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueTomorrowLabel: UILabel = {
        let label = UILabel()
        label.text = "------"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupUI()
    }
    
    //MARK: - Initialization VM
    init(viewModel: PopulationViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addBackgroundImage()
        setUpTitleLabel()
        setUpDescriptionLabel()
        addTextField()
        addButton()
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
    
    private func addTextField() {
        view.addSubview(countryNametextField)
        NSLayoutConstraint.activate([
            countryNametextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countryNametextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 100),
            countryNametextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
    
    private func addButton() {
        view.addSubview(populationButton)
        NSLayoutConstraint.activate([
            populationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            populationButton.topAnchor.constraint(equalTo: countryNametextField.bottomAnchor, constant: 40),
            populationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        addActionToSearchButton()
    }
    
    private func addActionToSearchButton() {
        populationButton.addAction(UIAction.init(handler: { [weak self] _ in
            self?.valueTodayLabel.text = self?.countryNametextField.text
        }), for: .touchUpInside)
    }
    
    private func addTodayLabel() {
        view.addSubview(todayLabel)
        NSLayoutConstraint.activate([
            todayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todayLabel.topAnchor.constraint(equalTo: populationButton.bottomAnchor, constant: 40),
            todayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func addValueTodayLabel() {
        view.addSubview(valueTodayLabel)
        NSLayoutConstraint.activate([
            valueTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            valueTodayLabel.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 40),
            valueTodayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func addTomorrowLabel() {
        view.addSubview(tomorrowLabel)
        NSLayoutConstraint.activate([
            tomorrowLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tomorrowLabel.topAnchor.constraint(equalTo: valueTodayLabel.bottomAnchor, constant: 40),
            tomorrowLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func addValueTomorrowLabel() {
        view.addSubview(valueTomorrowLabel)
        NSLayoutConstraint.activate([
            valueTomorrowLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            valueTomorrowLabel.topAnchor.constraint(equalTo: tomorrowLabel.bottomAnchor, constant: 40),
            valueTomorrowLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}


