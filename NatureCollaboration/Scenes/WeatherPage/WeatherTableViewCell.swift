import UIKit

final class WeatherTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FiraGO-Bold", size: 18)
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FiraGO-Regular", size: 16)
        label.textColor = .white
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FiraGO-Bold", size: 23)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.size.height -= 20
            super.frame = frame
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupCell() {
        backgroundColor = UIColor(red: 0.1682283282, green: 0.2181586623, blue: 0.3290845454, alpha: 1)
        layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        setupDateLabelConstraints()
        setupDescriptionLabelConstraints()
        setupTemperatureLabelConstraints()
    }
    
    // MARK: - Setup Constraints Methods
    private func setupDateLabelConstraints() {
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupTemperatureLabelConstraints() {
        contentView.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configuration
    func configure(date: String, description: String, temperature: String) {
        dateLabel.text = date
        descriptionLabel.text = description
        temperatureLabel.text = temperature
    }
}

