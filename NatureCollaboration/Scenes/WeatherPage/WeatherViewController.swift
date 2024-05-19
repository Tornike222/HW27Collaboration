import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: WeatherViewModel
    
    // MARK: - UI Components
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackgroundImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Page"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter the latitude and longitude to get the current weather information."
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
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
        return textField
    }()
    
    private let getWeatherButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle("Search", for: .normal)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - Initializers
    init(viewModel: WeatherViewModel){
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        self.viewModel.delegate = self
        setUpUI()
        setupGetWeatherAction()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherCell")
    }
    
    // MARK: - UI Setup
    private func setUpUI() {
        setUpBackgroundImage()
        setUpTitleLabel()
        setUpDescriptionLabel()
        setUpLatitudeLabel()
        setUpLatitudeTextField()
        setUpLongitudeLabel()
        setUpLongitudeTextField()
        setUpGetWeatherButton()
        setUpTableView()
    }
    
    private func setUpBackgroundImage() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    
    private func setUpLatitudeLabel() {
        view.addSubview(latitudeLabel)
        NSLayoutConstraint.activate([
            latitudeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            latitudeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            latitudeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpLatitudeTextField() {
        view.addSubview(latitudeTextField)
        NSLayoutConstraint.activate([
            latitudeTextField.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor, constant: 5),
            latitudeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            latitudeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpLongitudeLabel() {
        view.addSubview(longitudeLabel)
        NSLayoutConstraint.activate([
            longitudeLabel.topAnchor.constraint(equalTo: latitudeTextField.bottomAnchor, constant: 20),
            longitudeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            longitudeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpLongitudeTextField() {
        view.addSubview(longitudeTextField)
        NSLayoutConstraint.activate([
            longitudeTextField.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor, constant: 5),
            longitudeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            longitudeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpGetWeatherButton() {
        view.addSubview(getWeatherButton)
        NSLayoutConstraint.activate([
            getWeatherButton.topAnchor.constraint(equalTo: longitudeTextField.bottomAnchor, constant: 30),
            getWeatherButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getWeatherButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: getWeatherButton.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    private func setupGetWeatherAction() {
        let getWeatherAction = UIAction { [weak self] _ in
            guard let self = self else { return }
            let latitude = self.latitudeTextField.text ?? ""
            let longitude = self.longitudeTextField.text ?? ""
            self.viewModel.unwrapAndFetchWeatherData(latitude: latitude, longitude: longitude)
        }
        
        getWeatherButton.addAction(getWeatherAction, for: .touchUpInside)
    }
}

// MARK: - UITableViewDataSource Methods
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        let weatherData = viewModel.weatherInfo[indexPath.row]
        cell.configure(date: weatherData.date, description: weatherData.description, temperature: weatherData.temperature)
        return cell
    }
}

// MARK: - UITableViewDelegate Methods
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

// MARK: - WeatherViewModelDelegate Methods
extension WeatherViewController: WeatherViewModelDelegate {
    func updateWeatherInfo() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.latitudeTextField.text = ""
            self?.longitudeTextField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Preview
#Preview {
    WeatherViewController(viewModel: WeatherViewModel())
}

