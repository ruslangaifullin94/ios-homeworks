//
//  PhotoTableViewCell.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 03.04.2023.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    fileprivate let photo = Photo.make()
        
    private lazy var photoLabel: UILabel = {
       let photoLabel = UILabel()
        photoLabel.translatesAutoresizingMaskIntoConstraints = false
        photoLabel.text = "Photos"
        photoLabel.textColor = .black
        photoLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return photoLabel
    }()
    
    private lazy var showAllPhotosBut: UIButton = {
       let showAll = UIButton()
        showAll.translatesAutoresizingMaskIntoConstraints = false
        showAll.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        return showAll
    }()
    
    private lazy var imageCollection: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 8, right: 12)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.clipsToBounds = true
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        collection.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseID.photo.rawValue)

        return collection
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstrait()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstrait() {
        contentView.addSubview(photoLabel)
        contentView.addSubview(showAllPhotosBut)
        contentView.addSubview(imageCollection)
        
        NSLayoutConstraint.activate([
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            
            showAllPhotosBut.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            showAllPhotosBut.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            
            imageCollection.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            imageCollection.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            imageCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            imageCollection.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        
        ])
    }
  
    
}

extension PhotoTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private var sideInset: CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseID.photo.rawValue, for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
        let model = photo[indexPath.row]
        cell.setupCollectionTableCell(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (contentView.bounds.width - sideInset * 5) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    
    
}
