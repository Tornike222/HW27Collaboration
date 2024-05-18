//
//  WeatherViewController.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit
import Combine

class WeatherViewController: UIViewController, UITableViewDataSource {

    // MARK: - Properties
    private var viewModel = WeatherViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializers
    init(viewModel: WeatherViewModel = WeatherViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    private let latitudeLabel: UILabel = {
        let label = UILabel()
        label.text = "Latitude:"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let latitudeTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "e.g 40"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let longitudeLabel: UILabel = {
        let label = UILabel()
        label.text = "Longitude:"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let longitudeTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "e.g 74"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let getWeatherButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle("Get Weather by Coordinates", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
    
    // MARK: - UI Setup
    private func setupViews() {
        // Background Image
        let backgroundImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "BackgroundImage")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Add UI Elements
        view.addSubview(latitudeLabel)
        view.addSubview(latitudeTextField)
        view.addSubview(longitudeLabel)
        view.addSubview(longitudeTextField)
        view.addSubview(getWeatherButton)
        view.addSubview(tableView)
        view.addSubview(errorMessageLabel)
        
        // Constraints for Latitude Label
        NSLayoutConstraint.activate([
            latitudeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            latitudeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            latitudeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for Latitude TextField
        NSLayoutConstraint.activate([
            latitudeTextField.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor, constant: 5),
            latitudeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            latitudeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for Longitude Label
        NSLayoutConstraint.activate([
            longitudeLabel.topAnchor.constraint(equalTo: latitudeTextField.bottomAnchor, constant: 20),
            longitudeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            longitudeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for Longitude TextField
        NSLayoutConstraint.activate([
            longitudeTextField.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor, constant: 5),
            longitudeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            longitudeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for Get Weather Button
        NSLayoutConstraint.activate([
            getWeatherButton.topAnchor.constraint(equalTo: longitudeTextField.bottomAnchor, constant: 50),
            getWeatherButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getWeatherButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for Error Message Label
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: getWeatherButton.bottomAnchor, constant: 30),
            errorMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for TableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        latitudeTextField.addTarget(self, action: #selector(latitudeTextFieldDidEndEditing), for: .editingDidEndOnExit)
        getWeatherButton.addTarget(self, action: #selector(getWeatherButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Binding Setup
    private func setupBindings() {
        viewModel.$forecast
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: errorMessageLabel)
            .store(in: &cancellables)
    }
    
    // MARK: - Action Methods
    @objc private func latitudeTextFieldDidEndEditing() {
        viewModel.latitude = latitudeTextField.text ?? ""
    }
    
    @objc private func getWeatherButtonTapped() {
        viewModel.latitude = latitudeTextField.text ?? ""
        viewModel.longitude = longitudeTextField.text ?? ""
        viewModel.fetchWeatherByCoordinates()
    }
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        
        let weatherData = viewModel.forecast[indexPath.row]
        cell.textLabel?.text = "Temperature: \(weatherData.main.temp)°C"
        cell.detailTextLabel?.text = "Description: \(weatherData.weather.first?.description ?? "")"
        return cell
    }
}

// MARK: - Preview
#Preview {
    WeatherViewController(viewModel: WeatherViewModel())
}
