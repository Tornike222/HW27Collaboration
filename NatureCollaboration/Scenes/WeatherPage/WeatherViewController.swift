//
//  WeatherViewController.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDataSource, WeatherViewModelDelegate {

    // MARK: - Properties
    private var viewModel: WeatherViewModel
    
    // MARK: - Initializers
    init(viewModel: WeatherViewModel = WeatherViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
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
        textField.placeholder = "e.g 51.5074"
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
        textField.placeholder = "e.g -0.1278"
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
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
        
        // Constraints for TableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: getWeatherButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        getWeatherButton.addTarget(self, action: #selector(getWeatherButtonTapped), for: .touchUpInside) //selectors ar vikenebt
        
        tableView.dataSource = self
    }
    
    
    // MARK: - Action Methods
    @objc private func getWeatherButtonTapped() {           //uiaction
        let latitude = latitudeTextField.text ?? ""
        let longitude = longitudeTextField.text ?? ""
        viewModel.unwrapData(latitude: latitude, longitude: longitude)
    }
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        
        let weatherData = viewModel.weatherInfo[indexPath.row]
        cell.textLabel?.text = weatherData.title
        cell.detailTextLabel?.text = weatherData.value
        return cell
    }
    
    // MARK: - WeatherViewModelDelegate Methods
    
    func updateWeatherInfo() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Invalid input data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)    // tu arascoria daaclearos fildebi
    }
}

//// MARK: - Preview
//#Preview {
//    WeatherViewController(viewModel: WeatherViewModel())
//}

