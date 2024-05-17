//
//  SolarResourceViewController.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

class SolarResourceViewController: UIViewController {
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
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        addBackground()
    }
    

    //MARK: - Initialization VM
    init(viewModel: SolarResourceViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBackground() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

#Preview {
    SolarResourceViewController(viewModel: SolarResourceViewModel())
}
