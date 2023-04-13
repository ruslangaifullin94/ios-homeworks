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
    
    private lazy var backgroundPhotoView: UIView = {
        let photoView = UIView()
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.alpha = 0
        photoView.backgroundColor = .black
        photoView.isHidden = false
        return photoView
    }()
    
    private lazy var closePhotoButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.isHidden = true
        button.alpha = 0
        button.addTarget(self, action: #selector(cancelAnimation), for: .touchUpInside)
        return button
    }()
    
    private func setupConstraits() {
        
        view.addSubview(profilePhotoCollection)
        view.addSubview(backgroundPhotoView)
        view.addSubview(closePhotoButton)
        
        let safeAreaGuideLine = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profilePhotoCollection.topAnchor.constraint(equalTo: safeAreaGuideLine.topAnchor),
            profilePhotoCollection.leftAnchor.constraint(equalTo: safeAreaGuideLine.leftAnchor),
            profilePhotoCollection.bottomAnchor.constraint(equalTo: safeAreaGuideLine.bottomAnchor),
            profilePhotoCollection.rightAnchor.constraint(equalTo: safeAreaGuideLine.rightAnchor),
            
            backgroundPhotoView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundPhotoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundPhotoView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundPhotoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            closePhotoButton.topAnchor.constraint(equalTo: safeAreaGuideLine.topAnchor, constant: 10),
            closePhotoButton.rightAnchor.constraint(equalTo: safeAreaGuideLine.rightAnchor, constant: -10)

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
    
    @objc private func cancelAnimation() {
//        closePhoto(image: profileAvatar!, point: pointOnPhoto!)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let screen = UIScreen.main.bounds.width / (collectionView.cellForItem(at: indexPath)?.bounds.width)!
        UIView.animateKeyframes(
            withDuration: 1.5,
            delay: 0.1,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5)
                    {
                
                        collectionView.cellForItem(at: indexPath)!.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
                        collectionView.cellForItem(at: indexPath)!.transform = CGAffineTransform(scaleX: screen, y: screen)
                       
                        self.backgroundPhotoView.alpha = 0.5

                    }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3)
                    {
                        self.closePhotoButton.alpha = 1
                        collectionView.cellForItem(at: indexPath)!.layer.cornerRadius = 0.0
                        collectionView.cellForItem(at: indexPath)!.layer.borderWidth = 0
                        self.closePhotoButton.isHidden = false
                    }
              
            }
        )
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
