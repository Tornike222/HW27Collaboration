//
//  SpecieViewController.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

final class SpecieViewController: UIViewController {
    //MARK: - Properties
    private var viewModel: SpecieViewModel!
    
    //MARK: - UI Components
    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "BackgroundImage")
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Specie Page"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter the city name to get information about it's Species"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let searchLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.text = "Enter City"
        searchLabel.textColor = .white
        searchLabel.font = UIFont(name: "FiraGO-Medium", size: 18)
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        return searchLabel
    }()
    
    private let searchInputField: CustomTextField = {
        let searchInputField = CustomTextField()
        searchInputField.placeholder = "e.g Tbilisi"
        return searchInputField
    }()
    
    private let searchButton: CustomButton = {
        let searchButton = CustomButton()
        searchButton.setTitle("Search", for: .normal)
        return searchButton
    }()
    
    private let specieCollectionView: UICollectionView = {
        let specieCollectionFlowLayout = UICollectionViewFlowLayout()
        specieCollectionFlowLayout.scrollDirection = .vertical
        specieCollectionFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width-40, height:  UIScreen.main.bounds.width/1.3)
        specieCollectionFlowLayout.minimumLineSpacing = 20
        let specieCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.width/1.3), collectionViewLayout: specieCollectionFlowLayout)
        specieCollectionView.backgroundColor = .clear
        specieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return specieCollectionView
    }()
    
    private let customLoader = CustomLoader(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupUI()
        viewModel.delegate = self
        customLoader.addLoaderIndicator(view: view)
    }
    
    //MARK: - Initialization VM
    init(viewModel: SpecieViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - SetupUI
    private func setupUI(){
        addBackgroundImage()
        addTitleLabel()
        addDescriptionLabel()
        addSearchLabel()
        addSearchInputField()
        addSearchButton()
        addSpecieCollectionView()
    }
    
    private func addBackgroundImage(){
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addTitleLabel() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func addSearchLabel() {
        view.addSubview(searchLabel)
        NSLayoutConstraint.activate([
            searchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func addSearchInputField() {
        view.addSubview(searchInputField)
        NSLayoutConstraint.activate([
            searchInputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            searchInputField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            searchInputField.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 12),
        ])
    }
    
    private func addSearchButton() {
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            searchButton.topAnchor.constraint(equalTo: searchInputField.bottomAnchor, constant: 20),
        ])
        addSearchButtonAction()
    }
    
    private func addSearchButtonAction() {
        searchButton.addAction(UIAction(handler: { _ in
            self.searchInputField.endEditing(true)
            self.viewModel.fetchCityData(city: self.searchInputField.text )
        }), for: .touchUpInside)
    }
    
    private func addSpecieCollectionView() {
        view.addSubview(specieCollectionView)
        NSLayoutConstraint.activate([
            specieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            specieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            specieCollectionView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20),
            specieCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        specieCollectionView.dataSource = self
        specieCollectionView.register(SpecieCollectionViewCell.self, forCellWithReuseIdentifier: "SpecieCollectionView")
    }
}

//MARK: - UICollectionViewDataSource Extension
extension SpecieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.specieModel?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let specieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecieCollectionView", for: indexPath) as? SpecieCollectionViewCell
        
        specieCell?.parentViewController = self
        let currentSpecie = viewModel.specieModel?.results[indexPath.row]
        
        specieCell?.nameLabel.text = ("Name: " +  (currentSpecie?.taxon.name ?? ""))
        specieCell?.preferredName.text = ("Preferred Name: " +  (currentSpecie?.taxon.preferredCommonName ?? ""))
        specieCell?.photoAuthor.text = ("Author: " +  (viewModel.extractName(from: currentSpecie?.taxon.defaultPhoto.attribution) ?? ""))
        let imageUrl = URL(string: currentSpecie?.taxon.defaultPhoto.mediumUrl ?? "")!
        specieCell?.specieImage.loadImageWith(url: imageUrl)
        specieCell?.url = currentSpecie?.taxon.wikipediaUrl
        
        return specieCell ?? UICollectionViewCell()
    }
}

//MARK: - SpecieViewModelDelegate Extension
extension SpecieViewController: SpecieViewModelDelegate {
    func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.specieCollectionView.reloadData()
            self.customLoader.stopAnimation()
        }
    }
}
