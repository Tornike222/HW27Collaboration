//
//  SpecieViewController.swift
//  NatureCollaboration
//
//  Created by telkanishvili on 17.05.24.
//

import UIKit

class SpecieViewController: UIViewController {
    //MARK: - Properties
    var viewModel: SpecieViewModel!
    
    
    
    let postsCollectionView: UICollectionView = {
        let postCollectionFlowLayout = UICollectionViewFlowLayout()
        postCollectionFlowLayout.scrollDirection = .vertical
        postCollectionFlowLayout.itemSize = CGSize(width: 158, height: 192)
        postCollectionFlowLayout.minimumLineSpacing = 30
        let postsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: postCollectionFlowLayout)
        postsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        postsCollectionView.backgroundColor = .clear
        return postsCollectionView
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
    
    //MARK: - Initialization VM
    init(viewModel: SpecieViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
