//
//  PhotoCollectionViewCell.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 04.04.2023.
//

import UIKit
import iOSIntPackage

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Private Properties
    
    var photo: Photo?
    
    private lazy var imageCollectionCell: UIImageView = {
        let image = UIImageView(frame: .zero)
            image.translatesAutoresizingMaskIntoConstraints = false
            image.clipsToBounds = true
            image.layer.cornerRadius = 6
            return image
        }()
        
    //MARK: - Life Cycles
    
        override init(frame: CGRect) {
            super.init(frame: .zero)
            setupConstraits()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    
    //MARK: - Private Methods
    
        func setupCollectionTableCell(with photo: Photo) {
            self.photo = photo
            imageCollectionCell.image = UIImage(named: photo.imageTitle)
        }
    
        func setupCollectionCell(with image: UIImage) {
        imageCollectionCell.image = image
        }
        
        private func setupConstraits() {
            
            contentView.addSubview(imageCollectionCell)
            
            NSLayoutConstraint.activate([
                imageCollectionCell.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageCollectionCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageCollectionCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageCollectionCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
}
