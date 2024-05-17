//
//  AirQualityViewController.swift
//  NatureCollaboration
//
//  Created by sandrogelashvili on 17.05.24.
//

import UIKit

final class AirQualityViewController: UIViewController {
    //MARK: - Properties
    var viewModel: AirQualityViewModel!
    
    // MARK: - UI Components
    private let stackViewForQualityTitles: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.layer.borderWidth = 1.0
//        stack.layer.borderColor = UIColor.systemGray.cgColor
        return stack
    }()
    
    private let stackViewForQualityInfoLabels: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.borderWidth = 1.0
        stack.layer.borderColor = UIColor.systemGray.cgColor
        return stack
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setUpUI()
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
        view.addSubview(stackViewForQualityInfoLabels)
        NSLayoutConstraint.activate([
            stackViewForQualityTitles.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackViewForQualityTitles.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackViewForQualityTitles.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            stackViewForQualityInfoLabels.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackViewForQualityInfoLabels.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackViewForQualityInfoLabels.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        addLabelsToStackForQualityInfo(title: "Time :", value: "2024-05-17T10:00:00.000Z")
        addLabelsToStackForQualityInfo(title: "Aqius :", value: "22")
        addLabelsToStackForQualityInfo(title: "Mainus :", value: "p2")
        addLabelsToStackForQualityInfo(title: "Aqicn :", value: "16")
        addLabelsToStackForQualityInfo(title: "Maincn :", value: "n2")
        
        addDetailesToStackViewForQualityTitles(title: "Country :", placeholder: "e.g. Georgia")
        addDetailesToStackViewForQualityTitles(title: "State :", placeholder: "e.g. Imereti")
        addDetailesToStackViewForQualityTitles(title: "City :", placeholder: "e.g. Kutaisi")
        
    }
    
    // MARK: Methods
    func addLabelsToStackForQualityInfo(title: String, value: String) {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "FiraGO-Medium", size: 14)
        titleLabel.text = title
        
        let valueLabel = UILabel()
        valueLabel.font = UIFont(name: "FiraGO-Medium", size: 14)
        valueLabel.text = value
        
        let detailStack = UIStackView()
        detailStack.axis = .horizontal
        detailStack.distribution = .equalCentering
        detailStack.spacing = 10
        
        detailStack.addArrangedSubview(titleLabel)
        detailStack.addArrangedSubview(valueLabel)
        
        stackViewForQualityInfoLabels.addArrangedSubview(detailStack)
    }
    
    func addDetailesToStackViewForQualityTitles(title: String, placeholder: String) {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "FiraGO-Medium", size: 14)
        titleLabel.text = title
        
        let textField = UITextField()
        textField.font = UIFont(name: "FiraGO-Medium", size: 14)
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 5
        
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(textField)
        
        stackViewForQualityTitles.addArrangedSubview(verticalStack)
    }
    
    
    
}
#Preview {
    AirQualityViewController(viewModel: AirQualityViewModel())
}

