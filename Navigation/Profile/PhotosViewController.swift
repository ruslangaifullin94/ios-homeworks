//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 01.04.2023.
//

import UIKit

class PhotosViewController: UIViewController {
    
    fileprivate var photo = Photo.make()

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
    
    private func setupConstraits() {
        view.addSubview(profilePhotoCollection)
        
        let safeAreaGuideLine = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profilePhotoCollection.topAnchor.constraint(equalTo: safeAreaGuideLine.topAnchor),
            profilePhotoCollection.leftAnchor.constraint(equalTo: safeAreaGuideLine.leftAnchor),
            profilePhotoCollection.bottomAnchor.constraint(equalTo: safeAreaGuideLine.bottomAnchor),
            profilePhotoCollection.rightAnchor.constraint(equalTo: safeAreaGuideLine.rightAnchor)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.isNavigationBarHidden = false
        setupConstraits()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground

    }
    

}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var sideInset: CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseID.photoCollection.rawValue, for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
        let model = photo[indexPath.row]
        cell.setupCollectionCell(with: model)
        return cell
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
