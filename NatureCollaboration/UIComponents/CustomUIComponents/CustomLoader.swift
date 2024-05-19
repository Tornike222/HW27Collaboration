//
//  CustomLoader.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 19.05.24.
//

import UIKit

final class CustomLoader: UIImageView {

    // MARK: - Properties
    private let loaderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupLoader() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
    
    func addLoaderIndicator(view: UIView) {
        view.addSubview(loaderImage)
        NSLayoutConstraint.activate([
            loaderImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderImage.widthAnchor.constraint(equalToConstant: 50),
            loaderImage.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func startAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 1.0
        rotation.repeatCount = .infinity
        loaderImage.image = UIImage(named: "Loader")
        loaderImage.layer.add(rotation, forKey: "spin")
    }
    
    func stopAnimation() {
        loaderImage.layer.removeAllAnimations()
        loaderImage.image = UIImage()
    }
}

