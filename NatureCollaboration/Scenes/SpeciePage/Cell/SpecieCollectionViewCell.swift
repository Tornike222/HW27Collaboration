//
//  SpecieCollectionViewCell.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit
import SafariServices


final class SpecieCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    weak var parentViewController: UIViewController?
    
    var url: String? = "" {
        didSet {
            determineHideOrShow()
        }
    }
    //MARK: - UI Components
    let specieImage: UIImageView = {
        let specieImage = UIImageView()
        specieImage.translatesAutoresizingMaskIntoConstraints = false
        specieImage.layer.cornerRadius = 10
        specieImage.clipsToBounds = true
        return specieImage
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let photoAuthor: UILabel = {
        let photoAuthor = UILabel()
        photoAuthor.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        photoAuthor.textColor = .white
        photoAuthor.translatesAutoresizingMaskIntoConstraints = false
        return photoAuthor
    }()
    
    let preferredName: UILabel = {
        let preferredName = UILabel()
        preferredName.font = UIFont(name: "FiraGO-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        preferredName.textColor = .white
        preferredName.translatesAutoresizingMaskIntoConstraints = false
        return preferredName
    }()
    
    let wikipediaButton: UIButton = {
        let wikipediaButton = UIButton()
        wikipediaButton.translatesAutoresizingMaskIntoConstraints = false
        wikipediaButton.setImage(UIImage(named: "Wikipedia"), for: .normal)
        return wikipediaButton
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addWikipediaButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI Elements
    private func setupUI() {
        addLayer()
        addSpecieImage()
        addNameLabel()
        addPreferredLabel()
        addPhotoAuthorLabel()
        addWikipediaButton()
    }
    
    private func addLayer() {
        backgroundColor = #colorLiteral(red: 0.1682283282, green: 0.2181586623, blue: 0.3290845454, alpha: 1)
        layer.cornerRadius = 15
    }
    
    private func addSpecieImage() {
        addSubview(specieImage)
        NSLayoutConstraint.activate([
            specieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            specieImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            specieImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            specieImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func addNameLabel() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            nameLabel.topAnchor.constraint(equalTo: specieImage.bottomAnchor, constant: 30)
        ])
    }
    
    private func addPreferredLabel() {
        addSubview(preferredName)
        NSLayoutConstraint.activate([
            preferredName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            preferredName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            preferredName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func addPhotoAuthorLabel() {
        addSubview(photoAuthor)
        NSLayoutConstraint.activate([
            photoAuthor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            photoAuthor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            photoAuthor.topAnchor.constraint(equalTo: preferredName.bottomAnchor, constant: 10)
        ])
    }
    
    private func addWikipediaButton() {
        addSubview(wikipediaButton)
        NSLayoutConstraint.activate([
            wikipediaButton.topAnchor.constraint(equalTo: specieImage.bottomAnchor, constant: 30),
            wikipediaButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            wikipediaButton.widthAnchor.constraint(equalToConstant: 60),
            wikipediaButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    //MARK: - Wikipedia Button Action
    private func addWikipediaButtonAction() {
        wikipediaButton.addAction(UIAction(handler: { _ in
            if let url = URL(string: self.url ?? "") {
                let safariViewController = SFSafariViewController(url: url)
                self.parentViewController?.present(safariViewController, animated: true)
            }
        }), for: .touchUpInside)
    }
    
    private func determineHideOrShow() {
        if let urlString = url, !urlString.isEmpty, let _ = URL(string: urlString) {
            wikipediaButton.isHidden = false
        } else {
            wikipediaButton.isHidden = true
        }
    }
    
    func configure(nameLabelText: String, preferredNameText: String, photoAuthorText: String, imageUrl: String, wikipediaUrl: String) {
        nameLabel.text = nameLabelText
        preferredName.text = preferredNameText
        photoAuthor.text = photoAuthorText
        let imageUrl = URL(string: imageUrl)
        specieImage.loadImageWith(url: imageUrl!)
        url = wikipediaUrl
    }
    
}
