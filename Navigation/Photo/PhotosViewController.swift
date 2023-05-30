//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 01.04.2023.
//

import UIKit
class PhotosViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel: PhotoViewModelProtocol?
    
//    private let imagePublisherFacade = ImagePublisherFacade()
    private var newPhoto: [UIImage] = []
//    fileprivate var photo = Photo.make()

    private lazy var profilePhotoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseID.photoCollection.rawValue)
        return collection
    }()
    
   
   //MARK: - Life Cycles
    
    init(viewModel: PhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindModel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.isNavigationBarHidden = false
        setupConstraits()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        imagePublisherFacade.rechargeImageLibrary()
//        imagePublisherFacade.removeSubscription(for: self)
    }
    
    //MARK: - Methods
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "photo.fill.on.rectangle.fill"), style: .plain, target: self, action: #selector(setupFilters))
    }
    
    private func setupConstraits() {
        
        view.addSubview(profilePhotoCollection)
        let safeAreaGuideLine = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profilePhotoCollection.topAnchor.constraint(equalTo: safeAreaGuideLine.topAnchor),
            profilePhotoCollection.leftAnchor.constraint(equalTo: safeAreaGuideLine.leftAnchor),
            profilePhotoCollection.bottomAnchor.constraint(equalTo: safeAreaGuideLine.bottomAnchor),
            profilePhotoCollection.rightAnchor.constraint(equalTo: safeAreaGuideLine.rightAnchor),

        ])
        
    }
    
    private func bindModel() {
        viewModel?.stateChanger = { [weak self] state in
            guard let self = self else {return}
            switch state {
            case .filterOff:
                ()
            case .filterON:
                self.profilePhotoCollection.reloadData()
            }
            
        }
    }
    
    
    @objc private func setupFilters() {
        viewModel?.setupFiltersInCollection()

    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var sideInset: CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
}

//MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newPhotoAlbum.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseID.photoCollection.rawValue, for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
        let model = newPhotoAlbum[indexPath.item]
        cell.setupCollectionCell(with: model)
        return cell
    }
}

