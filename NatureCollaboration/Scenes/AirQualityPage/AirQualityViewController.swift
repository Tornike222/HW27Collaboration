//
//  AirQualityViewController.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

class AirQualityViewController: UIViewController {
    //MARK: - Properties
    var viewModel: AirQualityViewModel!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
    
    //MARK: - Initialization VM
    init(viewModel: AirQualityViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
